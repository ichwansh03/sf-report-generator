public class MDM_Controller {
    
    /*
     * Init MDM Controller by Faizir (20201006)
     */
    
    public DetailMDM mdmDetail{get;set;}
    public String polisNo {get;set;}
    public String entity {get;set;}
    public String relatedPolicy {get;set;}
    public String sourceCInd {get;set;}
    public String customerID {get;set;}
    public String customerRK {get;set;}
    public String socialSecurityNO {get;set;}
    public String firstNM {get;set;}
    public String birthDT {get;set;}
    public String genderCD {get;set;}
    public String accountNO {get;set;}
    public String addressTypeCD {get;set;}
    public String telephoneNo {get;set;}
    public String emailAddress {get;set;}
    Public String serializeError{get;set;}
    public String idMdm {get;set;}
    public string sessionId {get; set;}
    public static string contactID {get; set;}
    public Boolean isRender {get;set;}
    public String isDisplaySearch {get;set;}
    public String titleMDM {get;set;}
    public String processTime {get;set;}
    public Boolean isDataCustomerSuccess {get;set;}
    public Long mulai {get;set;}
    public Long selesai {get;set;}
    
    public MDM_Controller(ApexPages.StandardController controller) {
    }
    
    public MDM_Controller() {
    }
    
    public List<SelectOption> getEntityList() {
        List<SelectOption> tempList = new List<SelectOption>();
        //tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('AMFS', 'AMFS'));
        //tempList.add(new SelectOption('ALI', 'ALI'));
        return tempList;
    }
    
    public List<SelectOption> getRelatedPolicyList() {
        List<SelectOption> tempList = new List<SelectOption>();
        //tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('PARTY ONLY', 'PARTY ONLY'));
        //tempList.add(new SelectOption('PARTY AND CHILDREN', 'PARTY AND CHILDREN'));
        //tempList.add(new SelectOption('PARTY AND CHILDREN AND CROSSREFS', 'PARTY AND CHILDREN AND CROSSREFS'));
        return tempList;
    }
    
    public List<SelectOption> getSourceCIndList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption(EIPConstant.MDM_ID, 'MDM ID'));
        tempList.add(new SelectOption(EIPConstant.POLICY_NO, 'POLICY NO'));
        tempList.add(new SelectOption(EIPConstant.ID_DOC, 'ID NO'));
        tempList.add(new SelectOption(EIPConstant.ACC_NO, 'ACCOUNT NO'));
        tempList.add(new SelectOption(EIPConstant.PHONE_NO, 'PHONE NO'));
        tempList.add(new SelectOption(EIPConstant.EMAIL, 'EMAIL'));
        tempList.add(new SelectOption(EIPConstant.NAME_DOB_GENDER, 'NAME/DOB/GENDER'));
        return tempList;
    }
    
    public List<SelectOption> getGenderCDList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('M', 'MALE'));
        tempList.add(new SelectOption('F', 'FEMALE'));
        return tempList;
    }
    
    public List<SelectOption> getAddressTypeCDList() {
        List<SelectOption> tempList = new List<SelectOption>();
        tempList.add(new SelectOption('', '--None--'));
        tempList.add(new SelectOption('HOM', 'HOM'));
        tempList.add(new SelectOption('MOB', 'MOB'));
        tempList.add(new SelectOption('OFF', 'OFF'));
        return tempList;
    }
    
    public PageReference initGetData(){
        mulai =  DateTime.now().getTime();
        system.debug('mulai == '+mulai);
        String mdmId = ApexPages.CurrentPage().getParameters().get('mdmId');
        String entity = ApexPages.CurrentPage().getParameters().get('entity');
        String policyNo = ApexPages.CurrentPage().getParameters().get('policyNo');
        String preferedFormat = 'PARTY ONLY';
        // getMDM Customer Detail in MDM VFP
        // Start MDM Page NOT FROM Contact direct. Search menu will be displayed
        if(String.isEmpty(mdmId) && String.isEmpty(entity) && String.isEmpty(policyNo)){
            PageReference direct = new PageReference('/apex/MDM_VFP');
            isDisplaySearch = '';
            titleMDM = 'Search MDM';
        }else{
            // Start MDM Page FROM Contact direct. Search menu will not be displayed
            if(!String.isEmpty(mdmId)){
                System.debug('initGetData by MDMID');
                getData(null,entity,preferedFormat,EIPConstant.MDM_ID,mdmId,null,null,null,null,null,null,null,null);
            }else if(!String.isEmpty(policyNo)){
                System.debug('initGetData by PolicyNO');
                getData(policyNo,entity,preferedFormat,EIPConstant.POLICY_NO,null,null,null,null,null,null,null,null,null);
            }
            isDisplaySearch = 'none';
            titleMDM = 'Data MDM';
        }
        selesai =  Datetime.now().getTime();
        system.debug('selesai == '+selesai);
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        system.debug('processTime == '+processTime);
        
        return null;
    }
    
    public PageReference previous(){
        return Page.MDM_VFP;
    }
    
    public PageReference getData(){
        String appId = '';
        if(polisNo == '') polisNo = null;
        if(entity == '') entity = null;
        if(relatedPolicy == '') relatedPolicy = null;
        if(sourceCInd == '') sourceCInd = null;
        if(customerID == '') customerID = null;
        if(customerRK == '') customerRK = null;
        if(socialSecurityNO == '') socialSecurityNO = null;
        if(firstNM == '') firstNM = null;
        if(birthDT == '') birthDT = null;
        if(genderCD == '') genderCD = null;
        if(accountNO == '') accountNO = null;
        if(addressTypeCD == '') addressTypeCD = null;
        if(telephoneNo == '') telephoneNo = null;
        if(emailAddress == '') emailAddress = null;
        getData(polisNo,entity,relatedPolicy,sourceCInd,customerID,customerRK,socialSecurityNO,firstNM,birthDT,genderCD,accountNO,addressTypeCD,emailAddress);
        return null;
    }
    
    public void getData(String policyNo,String entiti,String preferedFormat,String searchFilter,String mdmId,String customerRK,String socialSecurityNO,String firstNM,String birthDT,String genderCD, String accountNO,String addressTypeCD,String emailAddress){
        isRender = false;
        mulai =  DateTime.now().getTime();
        system.debug('mulai == '+mulai);
        mdmDetail = new DetailMDM();
        String operation1 = '';
        String operation2 = '';
        operation1 = EIPConstant.OPERATION_RETRIEVE_CUSTOMER;
        String appId = 'MDM';
        customerID = mdmId;
        polisNo = policyNo;
        entity = entiti;
        sourceCInd = searchFilter;
        relatedPolicy = preferedFormat;
        isDataCustomerSuccess = false;
        EIPJson customerList;
        if(sourceCInd == EIPConstant.MDM_ID && customerID == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'MDM ID is required.'));
        }else if(sourceCInd == EIPConstant.MDM_ID && customerID != null) {
            System.debug('===================== Search by MDM ID');
            Map<String,List<String>> mapMDMID = new Map<String,List<String>>();
            List<String> mdmIdList = new List<String>();
            mdmIdList.add(customerID);
            mapMDMID.put(sourceCInd, mdmIdList);
            system.debug('===================== operation1 : '+operation1);
            system.debug('===================== entity : '+entity);
            system.debug('===================== appId : '+appId);
            system.debug('===================== relatedPolicy : '+relatedPolicy);
            system.debug('===================== mapMDMID : '+mapMDMID);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapMDMID);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY MDM ID'));
                system.debug ('================ ERROR IN SEARCH BY MDM ID : ' + e.getMessage() +' in Line '+e.getLineNumber()+' ================');
            }
        }
        
        if(sourceCInd == EIPConstant.POLICY_NO && polisNo == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Policy No is required.'));
        }else if(sourceCInd == EIPConstant.POLICY_NO && polisNo != null) {
            System.debug('===================== Search by Policy Number');
            Map<String,List<String>> mapPolicyNO = new Map<String,List<String>>();
            List<String> policyNoList = new List<String>();
            policyNoList.add(polisNo);
            mapPolicyNO.put(sourceCInd, policyNoList);
            System.debug('===================== mapPolicyNO : '+mapPolicyNO);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapPolicyNO);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY POLICY NO'));
                system.debug ('================ ERROR IN SEARCH BY POLICY NO : ' + e.getMessage() +' ================');
            }
        }
        
        if(sourceCInd == EIPConstant.ID_DOC && socialSecurityNO == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ID Doc Number is required.'));
        } else if(sourceCInd == EIPConstant.ID_DOC && socialSecurityNO != null) {
            System.debug('===================== Search by Social Security No');
            Map<String,List<String>> mapIDDoc = new Map<String,List<String>>();
            List<String> idDocList = new List<String>();
            idDocList.add(socialSecurityNO);
            mapIDDoc.put(sourceCInd, idDocList);
            System.debug('===================== mapIDDoc : '+mapIDDoc);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapIDDoc);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY ID DOC NO'));
                system.debug ('================ ERROR IN SEARCH BY ID DOC : ' + e.getMessage() +' ================');
            }
        }
        
        if(sourceCInd == EIPConstant.ACC_NO && accountNO == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Account Number is required.'));
        } else if(sourceCInd == EIPConstant.ACC_NO && accountNO != null) {
            System.debug('===================== Search by Account No');
            Map<String,List<String>> mapAccNo = new Map<String,List<String>>();
            List<String> accNoList = new List<String>();
            accNoList.add(accountNO);
            mapAccNo.put(sourceCInd, accNoList);
            System.debug('===================== mapAccNo : '+mapAccNo);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapAccNo);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY ACCOUNT NO'));
                system.debug ('================ ERROR IN SEARCH BY ACCOUNT NO : ' + e.getMessage() +' ================');
            }
        } 
        
        if(sourceCInd == EIPConstant.PHONE_NO && (telephoneNo == null || addressTypeCD == null)) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Phone Number and Address Type Code is required'));
        } else if(sourceCInd == EIPConstant.PHONE_NO && telephoneNo != null && addressTypeCD != null) {
            System.debug('===================== Search by Phone Number');
            Map<String,List<String>> mapPhoneNo = new Map<String,List<String>>();
            List<String> phoneNoList = new List<String>();
            phoneNoList.add(telephoneNo);
            phoneNoList.add(addressTypeCD);
            system.debug('phoneNoList : '+phoneNoList);
            mapPhoneNo.put(sourceCInd, phoneNoList);
            System.debug('===================== mapPhoneNo : '+mapPhoneNo);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapPhoneNo);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY PHONE NO'));
                system.debug ('================ ERROR IN SEARCH BY PHONE NO : ' + e.getMessage() +' ================');
            }
        }
        
        if(sourceCInd == EIPConstant.EMAIL && emailAddress == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Email is required.'));
        } else if(sourceCInd == EIPConstant.EMAIL && emailAddress != null) {
            System.debug('===================== Search by Email');
            Map<String,List<String>> mapEmail = new Map<String,List<String>>();
            List<String> emailList = new List<String>();
            emailList.add(emailAddress);
            mapEmail.put(sourceCInd, emailList);
            System.debug('===================== mapEmail : '+mapEmail);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapEmail);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY EMAIL'));
                system.debug ('================ ERROR IN SEARCH BY EMAIL : ' + e.getMessage() +' ================');
            }
        }
        
        if(sourceCInd == EIPConstant.NAME_DOB_GENDER && firstNM == null && birthDT == null && genderCD == null && customerRK == null) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'One of NAME / DOB / GENDER is required.'));
        } else if(sourceCInd == EIPConstant.NAME_DOB_GENDER && customerRK != null && (firstNM != null || birthDT != null || genderCD != null)) {
            System.debug('===================== Search by Name/DOB/Gender');
            Map<String,List<String>> mapNameDobGender = new Map<String,List<String>>();
            List<String> nameDobGenderList = new List<String>();
            if(birthDT != null){
                Datetime birth = date.parse(birthDT);
                birthDT = birth.format('yyyyMMdd');
            }
            nameDobGenderList.add(firstNM);
            nameDobGenderList.add(birthDT);
            nameDobGenderList.add(genderCD);
            nameDobGenderList.add(customerRK);
            mapNameDobGender.put(sourceCInd, nameDobGenderList);
            System.debug('===================== mapNameDobGender : '+mapNameDobGender);
            try{
                customerList = EIPConnector.getCustomerList(operation1, entity, appId, relatedPolicy, mapNameDobGender);
                isDataCustomerSuccess = mdmDetail.setDataCustomer(customerList,entity);
            }catch (Exception e) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR IN SEARCH BY NAME / DOB / GENDER'));
                system.debug ('================ ERROR IN SEARCH BY NAME / DOB / GENDER : ' + e.getMessage() +' ================');
            }
        }
        if(isDataCustomerSuccess) {
            isRender = true;
        } else {
            System.debug('customerList :'+customerList);
            if(customerList != null){
                if(customerList.errorCode != null){
                    if(!String.isEmpty(customerList.errorCode)){
                        if(customerList.errorCode.contains('ESG')){
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR Timeout from ESG ('+customerList.errorCode+' - '+customerList.errorMessage+' / '+customerList.errorDetail+')'));
                        }else{
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Data Available.('+customerList.errorCode+' - '+customerList.errorMessage+' / '+customerList.errorDetail+')'));
                        }
                    }
                }else if(customerList.reasonCode != null){
                    if(!String.isEmpty(customerList.reasonCode)){
                        if(customerList.reasonCode.contains('ESG')){
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'ERROR Timeout from ESG ('+customerList.reasonCode+' - '+customerList.message+' / '+customerList.reason+')'));
                        }else{
                            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Data Available.('+customerList.reasonCode+' - '+customerList.message+' / '+customerList.reason+')'));
                        }
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Data Available.'));
                }
            }
        }
        selesai =  Datetime.now().getTime();
        system.debug('selesai == '+selesai);
        processTime = 'Process ' + String.valueOf((selesai - mulai)/1000) + ' s';
        system.debug('processTime == '+processTime);
    }
    
    public PageReference direct(){
        PageReference direct;
        direct = new PageReference('/apex/MDM_CustomerDetail');
        return direct;
    }
    
    public PageReference getCustomerPortofolio(){
        PageReference direct;
        direct = new PageReference('/apex/MDM_CustomerPortofolio');
        return direct;
    }
    
    public class WrapperCustomerPortofolio{
        public String policyNumber {get;set;}
        Public String holderName{get;set;}
        Public String holderDob{get;set;}
        public String gender {get;set;}
        public String insuredName {get;set;}
        public String insuredDob {get;set;}
        public String insuredGender {get;set;}
        Public String productName {get;set;}
        Public String issuedDate {get;set;}
        Public String policyStatus {get;set;}
        Public String totalPremiumPaidRP {get;set;}
        Public String totalPremiumPaidUSD {get;set;}
        Public String payorName {get;set;}
        Public String debitAccountNo {get;set;}
        Public String applicationType {get;set;}
        Public String currencies {get;set;}
        public String paymentMode {get;set;}
        public String sumInsured {get;set;}
        public String totalAccountBalance {get;set;}
        public String fundAllocation {get;set;}
        public String navDate {get;set;}
        public String totalCharges {get;set;}
        public String fundCD {get;set;}
        public String errMDMFund{get;set;}
        public String errMDMInsuredDetail{get;set;}
        public String errMDMPolicyDetail{get;set;}
        public String errMDMGetContact{get;set;}
        
        public WrapperCustomerPortofolio(String policyNO, String nameInsured, String nameProduct, String dateIssued, String totalPaidRP, String totalPaidUSD, String currencies, 
                                         String paymentMode, String sumInsured, String totalAccountBalance, String fundAllocation, String navDate, String totalCharges,String fundCD, String errMDMFund, 
                                         String errMDMInsuredDetail, String errMDMPolicyDetail){
                                             this.policyNumber = policyNO;
                                             this.insuredName = nameInsured;
                                             this.productName = nameProduct;
                                             this.issuedDate = dateIssued;
                                             this.totalPremiumPaidRP = totalPaidRP;
                                             this.totalPremiumPaidUSD = totalPaidUSD;
                                             this.payorName = payorName;
                                             this.currencies = currencies;
                                             this.paymentMode = paymentMode;
                                             this.sumInsured = sumInsured;
                                             this.totalAccountBalance = totalAccountBalance;
                                             this.fundAllocation = fundAllocation;
                                             this.totalCharges = totalCharges;
                                             this.navDate = navDate;
                                             this.fundCD = fundCD;
                                             this.errMDMFund = errMDMFund;
                                             this.errMDMInsuredDetail = errMDMInsuredDetail;
                                             this.errMDMPolicyDetail = errMDMPolicyDetail;
                             }
    }
    
    public class WrapperCustomerDetail{
        public String policyNumber {get;set;}
        Public String holderName{get;set;}
        Public String holderDob{get;set;}
        public String gender {get;set;}
        public String insuredName {get;set;}
        public String insuredDob {get;set;}
        public String insuredGender {get;set;}
        Public String productName {get;set;}
        Public String issuedDate {get;set;}
        Public String policyStatus {get;set;}
        Public String totalPremiumPaidRP {get;set;}
        Public String totalPremiumPaidUSD {get;set;}
        Public String payorName {get;set;}
        Public String debitAccountNo {get;set;}
        Public String applicationType {get;set;}
        Public String currencies {get;set;}
        Public String contactID {get;set;}
        public Boolean isRenderContact {get;set;}
        public String errMDMAccDetail{get;set;}
        public String errMDMInsuredDetail{get;set;}
        public String errMDMPolicyDetail{get;set;}
        public String errMDMGetContact {get;set;}
        
        public WrapperCustomerDetail(String policyNO,String nameHolder, String dobHolder, String genderHolder, String nameInsured, String dobInsured, String genderInsured, 
                                     String nameProduct, String dateIssued, String statusPolicy,String totalPaidRP, String totalPaidUSD, String payorName, String noAccount, 
                                     String currencies, String contactID, Boolean isRenderContact,String errMDMAccDetail,String errMDMInsuredDetail, String errMDMPolicyDetail,
                                     String errMDMGetContact){
                                         this.policyNumber = policyNO;
                                         this.holderName = nameHolder;
                                         this.holderDob = dobHolder;
                                         this.gender = genderHolder;
                                         this.insuredName = nameInsured;
                                         this.insuredDob = dobInsured;
                                         this.insuredGender = genderInsured;
                                         this.productName = nameProduct;
                                         this.issuedDate = dateIssued;
                                         this.policyStatus = statusPolicy;
                                         this.totalPremiumPaidRP = totalPaidRP;
                                         this.totalPremiumPaidUSD = totalPaidUSD;
                                         this.payorName = payorName;
                                         this.debitAccountNo = noAccount;
                                         this.currencies = currencies;
                                         this.contactID = contactID;
                                         this.isRenderContact = isRenderContact;
                                         this.errMDMAccDetail = errMDMAccDetail;
                                         this.errMDMInsuredDetail = errMDMInsuredDetail;
                                         this.errMDMPolicyDetail = errMDMPolicyDetail;
                                         this.errMDMGetContact = errMDMGetContact;
                                     }
    }
    
    public class DetailMDM{
        public String mdmId{get;set;}
        public String sourceCInd {get;set;}
        public String mdmDetail {get;set;}
        public String policyNO{get;set;}
        public String accountName {get;set;}
        public String underwriterNM {get;set;}
        public String socialSecurityNO {get;set;}
        public String phoneNO {get;set;}
        public String applicationType {get;set;}
        public String faName {get;set;}
        public String branch {get;set;}
        public String salesArea {get;set;}
        public String gender {get;set;}
        public String dob {get;set;}
        public String region {get;set;}
        public String totalFundRP {get;set;}
        public String totalFundUSD {get;set;}
        public String fundAllocation {get; set;}
        public String totalCharges {get; set;}
        public String email {get;set;}
        public String totalPrePaidRP {get;set;}
        public String totalPrePaidUSD {get;set;}
        public String spvId {get;set;}
        public String atmId {get;set;}
        public String tsmId {get;set;}
        
        // ditampilkan di halaman Customer Portofolio
        public String errMDMAgentInfo {get;set;}
        public String errMDMCustProfile {get;set;}
        public String errMDMPolicyDetailCustPortofolio {get;set;}
        public String errMDMInsuredDetailCustPortofolio {get;set;}
        
        public map<String, List<WrapperCustomerPortofolio>> mapMDMCustomerPortofolio {get;set;} // to wrap data to page Customer Portofolio Page
        public map<String, List<WrapperCustomerDetail>> mapMDMCustomerDetail {get;set;} // to wrap data to page Customer Detail Page
        public Map<String,Decimal> mapCurrencyPrePaid {get;set;}
        public Map<String,Decimal> mapCurrencyAccBallance {get;set;}
        List<String> polisNOs = new List<String>();
        Map<String,String> mapApplication = new Map<String, String>();
        Map<String,String> mapInsured = new Map<String,String>();
        Map<String,String> mapHolder = new Map<String,String>();
        
        public Boolean setDataCustomer(EIPJson dataCustomerEIP, String entity){
            mapMDMCustomerPortofolio = new map<String, List<WrapperCustomerPortofolio>>();
            mapMDMCustomerDetail = new map<String, List<WrapperCustomerDetail>>();
            phoneNO = '';
            socialSecurityNO = '';
            totalPrePaidRP = '';
            totalPrePaidUSD = '';
            totalFundRP = '';
            totalFundUSD = '';
            
            // error messages untuk page yang berbeda
            // setiap error message diambil dari beda2 service
            String errMDMFund; // hanya ditampilkan pada page Customer Portofolio
            String errMDMAccDetail; // hanya ditampilkan pada page Customer Detail
            String errMDMInsuredDetail; // ditampilkan pada page Customer Detail  dan Customer Portofolio
            String errMDMPolicyDetail; // ditampilkan pada page Customer Detail  dan Customer Portofolio
            String errMDMGetContact;
            List<String> errInsuredDetailList = new List<String>();
            List<String> errInsuredDetailListNoData = new List<String>();
            List<String> errPolicyDetailList = new List<String>();
            List<String> errPolicyDetailListNoData = new List<String>();
            List<String> errCustProfileList = new List<String>();
            List<String> errCustProfileListNoData = new List<String>();
            
            String accountFirstNM;
            String accountLastNM;
            Boolean successSetDataCustomer = false;
            Map<String,Decimal> mapCurrencyPrePaid = new map<String, Decimal>();
            Map<String,Decimal> mapCurrencyAccBallance = new map<String, Decimal>();
            List<String> converter = new String[]{'0','number','###,###,##0.00'};
            Decimal totalPrePaidRPDec = 0;
            Decimal totalPrePaidUSDDec = 0;
            String totalCharges;
            Boolean isRenderContact;
            Decimal totalFundRPDec = 0;
            Decimal totalFundUSDDec = 0;
            if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount != null){
                mdmId = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.customerID;
                // alternatively get MDM ID from insuredID
                if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn != null){
                    if(mdmId == null){
                        mdmId = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID;
                    }
                    accountFirstNM = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM;
                    accountLastNM = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM;
                    accountName = (accountFirstNM == null ? '' : accountFirstNM) + ' ' + (accountLastNM == null ? '' : accountLastNM);
                    dob = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT;
                    dob = dob != null ? dob.substring(6,8)+'-'+dob.substring(4,6)+'-'+dob.substring(0,4) : '';
                    gender = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].genderCD;
                }
                if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size() > 0){
                    if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn.size() > 0){
                        List<Contact> contactsPolicy = [Select Policy_No__c, PolicyApp__c, Name from Contact where mdmid_owner__c =: mdmId and mdmid_owner__c != null];
                        for(Integer i = 0; i < dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn.size();i++){
                            for(Integer j = 0 ; j < dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn.size(); j++){
                                Boolean isPrimaryAddressFLG = (dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].primaryAddressFLG == 'Y');
                                String addressTypeCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].addressTypeCD;
                                String documentTypeCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].documentTypeCD;
                                if(isPrimaryAddressFLG){
                                    if (documentTypeCD == 'KTP'){
                                        socialSecurityNO = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].socialSecurityNO;
                                    }
                                    if(addressTypeCD == 'MOB'){
                                        phoneNO = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].telephoneNO;
                                    }
                                    if(addressTypeCD == 'EML'){
                                        email = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].emailAddress.toLowerCase();
                                    }
                                    if(addressTypeCD == 'HA'){
                                        String address1 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].addressLine1;
                                        String address2 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].addressLine2;
                                        String address3 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].addressLine3;
                                        String address4 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[i].hasPersonalDetailsIn[j].hasAddressesIn[0].addressLine4;
                                        String address = '';
                                        if(address1 != null && address2 != null && address3 != null && address4 != null ) {
                                            address += (address1 != null ? address1 : '') + ',' + (address2 != null ? address2 : '') + ',' + (address3 != null ? address3 : '') + ',' + (address4 != null ? address4 : '');
                                        }
                                    }
                                }
                            }
                        }
                        if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn != null){
                            for(Integer i = 0; i < dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn.size();i++){
                                String customerTypeCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].customerTypeCD;
                                String underwriterFirstName = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.firstNM;
                                String underwriterLastName = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.lastNM;
                                String underwriter;
                                String applicationTypeCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].sourceChannelCD;
                                String noPolis = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].policyNO;
                                
                                // get insured name
                                if(customerTypeCD == 'INS'){
                                    underwriter = (underwriterFirstName == null ? '' : underwriterFirstName) + ' ' + (underwriterLastName == null ? '' : underwriterLastName);
                                    mapInsured.put(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].policyNO, underwriter);
                                
                                // get owner name
                                }else if (customerTypeCD == 'OWN'){
                                    underwriter = underwriterFirstName != null ? underwriterFirstName : '' + ' ' + underwriterLastName != null ? underwriterLastName : '';
                                    policyNO = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasCustomerInformationIn[i].hasPolicyAccount[0].policyNO;
                                }

                                // Get List Polis No with same MDM ID from RLS
                                if(policyNO != null || !String.isEmpty(policyNO)){
                                    if(!polisNOs.contains(policyNO)){
                                        polisNOs.add(policyNO);
                                        mapApplication.put(policyNO, applicationTypeCD);
                                    }
                                }
                                // Get List Polis No with same MDM ID from Database Salesforce
                                for(Contact con : contactsPolicy){
                                    if(!polisNOs.contains(con.Policy_No__c)){
                                        polisNOs.add(con.Policy_No__c);
                                        mapApplication.put(con.Policy_No__c, con.PolicyApp__c);
                                        mapHolder.put(con.Policy_No__c, con.Name);
                                    }
                                }
                            }
                        }else if(dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn != null){
                            for(Integer i = 0; i < dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn.size();i++){
                                policyNO = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[i].applicationNO;
                                String underwriter = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[i].underwriterNM;
                                String applicationTypeCD = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[i].applicationTypeCD;
                                if(!polisNOs.contains(policyNO)){
                                    polisNOs.add(policyNO);
                                    mapApplication.put(policyNO, applicationTypeCD);
                                }
                            }
                        }
                        
                        // Start getting data per policy No
                        List<WrapperCustomerPortofolio> wrapperCustomerPortofolio = new List<WrapperCustomerPortofolio>();
                        List<WrapperCustomerDetail> wrapperCustomerDetail = new List<WrapperCustomerDetail>();
                        for(Integer i = 0 ; i < polisNOs.size(); i++){
                            System.debug('Policy No ke :'+(i+1)+' == '+polisNOs[i]);
                            Map<String,List<String>> mapFundCD = new Map<String,List<String>>();
                            Map<String,String> mapFundAllocation = new Map<String,String>();
                            
                            // Local variables to used in Wrapper
                            String holderName;
                            String insuredName;
                            Decimal totalPaidRP = 0;
                            Decimal totalPaidUSD = 0;
                            String totalPremiumPaid;
                            String totalPremiumPaidRP;
                            String totalPremiumPaidUSD;
                            
                            String dobPerPolis;
                            String InsuredDobPerPolis;
                            String genderPerPolis ;
                            String insuredGenderPerPolis ;
                            String statusPerPolis ;
                            String nameProductPerPolis ;
                            String issuedDatePerPolis ;
                            String payorNamePerPolis ;
                            String currenciesPerPolis ;
                            String paymentModePerPolis ;
                            String sumInsuredPerPolis ;
                            Decimal totalFundAmountPerPolis ;
                            String navDatePerPolis ;
                            String fundAmountPerPolis = '';
                            String fundAllocationPerPolis = '';
                            String accountNoPerPolis;
                            String fundCD;
                            
                            // Refresh all error message for next policy no
                            errMDMFund = null;
                            errMDMAccDetail = null;
                            errMDMInsuredDetail = null;
                            errMDMPolicyDetail = null;
                            errMDMGetContact = null;
                                
                            String dobs = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT;
                            dobPerPolis = dobs.substring(6,8)+'-'+dobs.substring(4,6)+'-'+dobs.substring(0,4);
                            genderPerPolis = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].genderCD;
                            holderName = mapHolder.get(polisNOs[i]);
                            if(holderName == null){
                                String name1 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM;
                                String name2 = dataCustomerEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM;
                                holderName = (name1 == null ? '' : name1) + ' ' + (name2 == null ? '' : name2);
                            }
                            applicationType = mapApplication.get(polisNOs[i]);
                            // applicationType for DMTM policy is not available for getFundDetail with operation fund and getCustomerInfo with operation account detail
                            if(applicationType != 'DMTM'){
                                //Get Fund Detail
                                try{
                                    List<String> listFundCD = new List<String>();
                                    EIPJson fundDetail  = EIPConnector.getFundDetail(EIPConstant.OPERATION_FUND, entity, applicationType, polisNOs[i]);
                                    EIPJson.EIP_AgSa_InsurancePolicy fund = fundDetail.Body.AgSa_InsurancePolicy_Type;
                                    if(fund.hasAccountDetailsIn != null){
                                        if(fund.hasAccountDetailsIn[0].hasInvestmentFundDetailsIn != null){
                                            for(Integer j = 0;j <fund.hasAccountDetailsIn.size();j++){
                                                fundAmountPerPolis = fund.hasAccountDetailsIn[0].hasInvestmentFundDetailsIn[0].totalFundAmount;
                                                navDatePerPolis = fund.hasAccountDetailsIn[j].hasInvestmentFundDetailsIn[0].navDt;
                                                navDatePerPolis = navDatePerPolis.substring(6,8)+'-'+navDatePerPolis.substring(4,6)+'-'+navDatePerPolis.substring(0,4);
                                                fundAllocationPerPolis = fund.hasAccountDetailsIn[j].hasInvestmentFundDetailsIn[0].fundAllocation;
                                                fundCD = fund.hasAccountDetailsIn[j].hasInvestmentFundDetailsIn[0].investmentFundCd != null? fund.hasAccountDetailsIn[j].hasInvestmentFundDetailsIn[0].investmentFundCd.trim() : '';
                                                if(fundCD != ''){
                                                    mapFundAllocation.put(fundCD, fundAllocationPerPolis);
                                                    listFundCD.add(fundCD);
                                                    mapFundCD.put(polisNOs[i], listFundCD);
                                                }
                                            }
                                        }
                                    }
                                }catch(EIPConnector.NoDataException e){
                                    errMDMFund = 'Tidak ada data sewaktu pengambilan data '+EIPConstant.OPERATION_FUND;
                                }catch (Exception e) {
                                    errMDMFund = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_FUND;
                                    system.debug ('================ ERROR IN getFundDetail Method operation : '+EIPConstant.OPERATION_FUND+' , message : ' + e.getMessage() +' in line '+e.getLineNumber()+' ================');
                                }
                                
                                // Get Account Detail
                                try{
                                    EIPJson accountDetail = EIPConnector.getCustomerInfo(EIPConstant.OPERATION_ACCOUNT_DETAIL, entity, applicationType, polisNOs[i]);
                                    accountNoPerPolis = accountDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.hasPartyAccountDetailsIn.accountNO;
                                    String firstName = accountDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM;
                                    String lastName = accountDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].canBeIndividual.hasPartyAccountDetailsIn.payorLastNM;
                                    payorNamePerPolis = (firstName != null ? firstName + ' ' : '') + (lastName != null ? lastName : '');
                                }catch(EIPConnector.NoDataException e){
                                    System.debug('No Data Exception EIP Connector sendRequest');
                                    errMDMAccDetail = 'Tidak ada data sewaktu pengambilan data '+EIPConstant.OPERATION_ACCOUNT_DETAIL;
                                }catch (Exception e) {
                                    errMDMAccDetail = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_ACCOUNT_DETAIL;
                                    system.debug ('================ ERROR IN getCustomerInfo Method operation : '+EIPConstant.OPERATION_ACCOUNT_DETAIL+', message : ' + e.getMessage() +' in line '+e.getLineNumber()+' ================');
                                }
                            }
                            
                            // Get Insured Data operation Insured Detail
                            try{
                                EIPJson insuredDetails = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_INSURED_DETAIL, entity, applicationType, polisNOs[i]);
                                insuredGenderPerPolis = insuredDetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].genderCD;
                                String firstNM = insuredDetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM;
                                String lastNM = insuredDetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM;
                                insuredName = mapInsured.get(polisNOs[i]);
                                insuredName = insuredName == null ? (firstNM != null ? firstNM + ' ' : '') + (lastNM != null ? lastNM : '') : insuredName;
                                insuredDobPerPolis = insuredDetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT;
                            }catch(EIPConnector.NoDataException e){
                                errMDMInsuredDetail = 'Tidak ada data '+EIPConstant.OPERATION_INSURED_DETAIL;
                                errInsuredDetailListNoData.add(polisNOs[i]);
                                errMDMInsuredDetailCustPortofolio = 'Tidak ada data '+EIPConstant.OPERATION_INSURED_DETAIL+' pada polis '+errInsuredDetailListNoData;
                            }catch (Exception e) {
                                errMDMInsuredDetail = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_INSURED_DETAIL;
                                errInsuredDetailList.add(polisNOs[i]);
                                errMDMInsuredDetailCustPortofolio = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_INSURED_DETAIL+' pada polis '+errInsuredDetailList;
                                system.debug ('================ ERROR IN getPolicyDetails Method operation : '+EIPConstant.OPERATION_INSURED_DETAIL+', message : ' + e.getMessage() +' ================');
                            }
                            
                            // Get Policy Details operation Policy Detail
                            try{
                                EIPJson policyDetails = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_POLICY_DETAIL, entity, applicationType, polisNOs[i]);
                                EIPJson.EIP_IcAx_AXAAsiaCustomer policy = policyDetails.Body.IcAx_AXAAsiaCustomer_Type;
                                if(policy.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct != null){
                                    nameProductPerPolis = policy.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planCD;
                                    sumInsuredPerPolis = (policy.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured != null) ? policy.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured.trim() : '0';
                                    sumInsuredPerPolis = String.format(Decimal.valueOf(sumInsuredPerPolis).format(), converter); // formatter money format
                                }
                                currenciesPerPolis = policy.hasPolicyAccount[0].currencyCD;
                                issuedDatePerPolis = policy.hasPolicyAccount[0].issueDt;
                                issuedDatePerPolis = issuedDatePerPolis.substring(6,8)+'-'+issuedDatePerPolis.substring(4,6)+'-'+issuedDatePerPolis.substring(0,4);
                                statusPerPolis = policy.hasPolicyAccount[0].policyStatusCD;
                                totalPremiumPaid = (policy.hasPolicyAccount[0].premiumAMT) != null ? (policy.hasPolicyAccount[0].premiumAMT).trim() : '0'; // String
                                if(currenciesPerPolis != null){
                                    if(currenciesPerPolis.trim() == 'RP'){
                                        totalPremiumPaidRP = (totalPremiumPaid) != null ? (totalPremiumPaid).trim() : '0'; // String
                                        totalPaidRP = Decimal.valueOf(totalPremiumPaidRP); // convert totalPremiumPaid to Decimal
                                        totalPremiumPaidRP = String.format(totalPaidRP.format(), converter); // formatter money format
                                        totalPrePaidRPDec += totalPaidRP; // add all total premium paid
                                        totalPrePaidRP  = String.format(totalPrePaidRPDec.format(), converter); // formatter money format
                                    }
                                    if(currenciesPerPolis.trim() == 'USD'){
                                        totalPremiumPaidUSD = (totalPremiumPaid) != null ? (totalPremiumPaid).trim() : '0'; // String
                                        totalPaidUSD = Decimal.valueOf(totalPremiumPaidUSD); // convert totalPremiumPaid to Decimal
                                        totalPremiumPaidUSD = String.format(totalPaidUSD.format(), converter); // formatter money format
                                        totalPrePaidUSDDec += totalPaidUSD; // add all total premium paid
                                        totalPrePaidUSD  = String.format(totalPrePaidUSDDec.format(), converter); // formatter money format
                                    }
                                }else{
                                    currenciesPerPolis = 'Rp';
                                    totalPremiumPaidRP = (totalPremiumPaid) != null ? (totalPremiumPaid).trim() : '0'; // String
                                    totalPaidRP = Decimal.valueOf(totalPremiumPaidRP); // convert totalPremiumPaid to Decimal
                                    totalPremiumPaidRP = String.format(totalPaidRP.format(), converter); // formatter money format
                                    totalPrePaidRPDec += totalPaidRP; // add all total premium paid
                                    totalPrePaidRP  = String.format(totalPrePaidRPDec.format(), converter); // formatter money format
                                }
                                if(policy.hasPolicyAccount[0].isAssociatedWithIssuer != null){
                                    spvId = policy.hasPolicyAccount[0].isAssociatedWithIssuer.issuerID;
                                    atmId = policy.hasPolicyAccount[0].isAssociatedWithIssuer.issuerAppID;
                                    tsmId = policy.hasPolicyAccount[0].isAssociatedWithIssuer.issuerRk;
                                }
                                
                                paymentModePerPolis = policy.hasPolicyAccount[0].paymentModeCD;
                            }catch(EIPConnector.NoDataException e){
                                errMDMPolicyDetail = 'Tidak ada data '+EIPConstant.OPERATION_POLICY_DETAIL;
                                errPolicyDetailListNoData.add(polisNOs[i]);
                                errMDMPolicyDetailCustPortofolio = 'Tidak ada data '+EIPConstant.OPERATION_POLICY_DETAIL+' pada polis '+errPolicyDetailListNoData;
                            }catch (Exception e) {
                                errMDMPolicyDetail = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_POLICY_DETAIL;
                                errPolicyDetailList.add(polisNOs[i]);
                                errMDMPolicyDetailCustPortofolio = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_POLICY_DETAIL+' pada polis '+errPolicyDetailList;
                                system.debug ('================ ERROR IN getPolicyDetails Method operation : '+EIPConstant.OPERATION_POLICY_DETAIL+', message : ' + e.getMessage() +' in Line '+e.getLineNumber()+ '================');
                            }
                            
                            String servicingCD;
                            // Get Customer Info operation Customer Profile
                            try{
                                EIPJson dataCustomerEIP2 = EIPConnector.getCustomerInfo(EIPConstant.OPERATION_CUST_PROFILE,entity, applicationType, polisNOs[i]);
                                servicingCD = dataCustomerEIP2.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
                            }catch(EIPConnector.NoDataException e){
                                System.debug('No Data Exception EIP Connector sendRequest');
                                errCustProfileListNoData.add(polisNOs[i]);
                                errMDMCustProfile = 'Tidak ada data '+EIPConstant.OPERATION_CUST_PROFILE+' pada polis '+errCustProfileListNoData;
                            }catch (Exception e) {
                                errCustProfileList.add(polisNOs[i]);
                                errMDMCustProfile = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_CUST_PROFILE+' pada polis '+errCustProfileList;
                                system.debug ('================ ERROR IN getCustomerInfo Method operation : '+EIPConstant.OPERATION_CUST_PROFILE+', message : ' + e.getMessage() +' in line '+e.getLineNumber()+' ================');
                            }
                            
                            // Get Agent Info
                            if(servicingCD != null && String.isNotEmpty(servicingCD) && String.isNotBlank(servicingCD)){
                                try{
                                    servicingCD = (applicationType == 'RLS') ? servicingCD.substring(9, 15) : servicingCD;
                                    EIPJson dataAgentEIP = EIPConnector.getAgentInfo(EIPConstant.OPERATION_AGENT_INFO, entity, applicationType, servicingCD, null, true);
                                    string fName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.firstNM;
                                    string mName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.middleNM;
                                    string lName = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].canBeIndividual.lastNM;
                                    faName = (fName == null ? '' : fName)+' '+(mName == null ? '' : mName)+' '+(lName == null ? '' : lName);
                                    branch = dataAgentEIP.Body.AgSa_InsurancePolicy_Type.hasPartyDetailsIn[0].branchCD;
                                }catch(EIPConnector.NoDataException e){
                                    System.debug('No Data Exception EIP Connector sendRequest');
                                    errMDMAgentInfo = 'Tidak ada data '+EIPConstant.OPERATION_AGENT_INFO;
                                }catch (Exception e) {
                                    errMDMAgentInfo = 'ERROR sewaktu pengambilan Data '+EIPConstant.OPERATION_AGENT_INFO;
                                    system.debug ('================ ERROR IN getAgentInfo Method operation : '+EIPConstant.OPERATION_AGENT_INFO+', message : ' + e.getMessage() +' ================');
                                }
                            }
                            
                            // untuk memvalidasi apakah polis ini terdaftar di SFDC
                            List<Contact> contacts = new List<Contact>();
                            if(polisNOs[i] != null){
                                contacts = [SELECT Id from Contact where Policy_No__c =: polisNOs[i]];
                                if(contacts.size() > 0){
                                    contactID = contacts[0].Id;
                                    isRenderContact = true;
                                }else{
                                    isRenderContact = false;
                                    errMDMGetContact = 'Tidak ada data polis pada Policy No : '+polisNOs[i];
                                }
                            }else{
                                isRenderContact = false;
                                errMDMGetContact = 'Tidak ada data polis pada Policy No : '+polisNOs[i];
                            }
                            
                            // To Differentiate Fund Allocation in different Policy No
                            fundAllocation = (fundAllocationPerPolis == null || String.isEmpty(fundAllocationPerPolis) || fundAllocationPerPolis.trim() == '' ? '0' : fundAllocationPerPolis);
                            String totalFundAmountPerPolisStr = (fundAmountPerPolis == null || String.isEmpty(fundAmountPerPolis) || fundAmountPerPolis.trim() == '') ? '0' : fundAmountPerPolis.trim();
                            // Add all totalFund in All Policy
                            totalFundAmountPerPolis = Decimal.valueOf(totalFundAmountPerPolisStr);
                            totalFundAmountPerPolisStr = String.format(totalFundAmountPerPolis.format(), converter); // formatter money format
                            
                            // To Differentiate Total Fund Amount in different policy no with different currency
                            if(currenciesPerPolis != null){
                                if(currenciesPerPolis.trim() == 'RP'){
                                    totalFundRPDec += totalFundAmountPerPolis;
                                    totalFundRP = (String.format(totalFundRPDec.format(), converter) != null && String.format(totalFundRPDec.format(), converter) != '') ? String.format(totalFundRPDec.format(), converter) : '0'; // formatter money format
                                }
                                if(currenciesPerPolis.trim() == 'USD'){
                                    totalFundUSDDec += totalFundAmountPerPolis;
                                    totalFundUSD = (String.format(totalFundUSDDec.format(), converter) != null && String.format(totalFundUSDDec.format(), converter) != '') ? String.format(totalFundUSDDec.format(), converter) : '0'; // formatter money format
                                }
                            }
                            currenciesPerPolis = currenciesPerPolis != null ? currenciesPerPolis : '-';
                            insuredDobPerPolis = insuredDobPerPolis == null ? '' : insuredDobPerPolis.substring(6,8)+'-'+insuredDobPerPolis.substring(4,6)+'-'+insuredDobPerPolis.substring(0,4);
                            totalCharges = '';
                            
                            // perbedaan antara wrapperCustomerPortofolio and wrapperCustomerDetail adalah
                            // di wrapperCustomerPortofolio ada looping untuk policy number jika satu polis punya lebih dari 1 fund code (untuk membedakan fund allocation dari tiap fund code)
                            if(mapFundCD.size() > 0){
                                for(Integer j = 0;j < mapFundCD.get(polisNOs[i]).size();j++){
                                    wrapperCustomerPortofolio.add(new WrapperCustomerPortofolio(polisNOs[i], insuredName, nameProductPerPolis, issuedDatePerPolis,
                                                                                                totalPremiumPaidRP, totalPremiumPaidUSD, currenciesPerPolis, paymentModePerPolis, sumInsuredPerPolis, 
                                                                                                totalFundAmountPerPolisStr, mapFundAllocation.get(mapFundCD.get(polisNOs[i])[j]),navDatePerPolis, totalCharges, 
                                                                                                mapFundCD.get(polisNOs[i])[j],errMDMFund, errMDMInsuredDetail, 
                                                                                                errMDMPolicyDetail));
                                }
                            }else{
                                    wrapperCustomerPortofolio.add(new WrapperCustomerPortofolio(polisNOs[i], insuredName, nameProductPerPolis, issuedDatePerPolis,
                                                                                                totalPremiumPaidRP, totalPremiumPaidUSD, currenciesPerPolis, paymentModePerPolis, sumInsuredPerPolis, 
                                                                                                totalFundAmountPerPolisStr, fundAllocation, navDatePerPolis, totalCharges, fundCD, errMDMFund, errMDMInsuredDetail, 
                                                                                                errMDMPolicyDetail));
                            }
                            
                            // wrapperCustomerDetail no need to loop because there is no variable to be loop
                            wrapperCustomerDetail.add(new WrapperCustomerDetail(polisNOs[i], holderName, dobPerPolis, genderPerPolis, insuredName, insuredDobPerPolis, insuredGenderPerPolis, nameProductPerPolis, issuedDatePerPolis, statusPerPolis,
                                                        totalPremiumPaidRP, totalPremiumPaidUSD, payorNamePerPolis, accountNoPerPolis, currenciesPerPolis, contactID,isRenderContact, errMDMAccDetail, errMDMInsuredDetail, 
                                                                                                errMDMPolicyDetail, errMDMGetContact));
                            System.debug('Ended for Policy No '+polisNOs[i]);
                        }
                        
                        if(wrapperCustomerPortofolio.size() > 0 && wrapperCustomerDetail.size() > 0){
                            mapMDMCustomerPortofolio.put('Customer Policy List of MDM ID : '+mdmId,wrapperCustomerPortofolio);
                            mapMDMCustomerDetail.put('Customer Policy List of MDM ID : '+mdmId,wrapperCustomerDetail);
                            successSetDataCustomer = true;
                        }
                    }
                }
            }
            return successSetDataCustomer;
        }
    }
}