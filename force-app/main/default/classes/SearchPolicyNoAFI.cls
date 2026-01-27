global with sharing class SearchPolicyNoAFI {
    
    public String searchPolicyNo {get;set;}
    public AppDetail applicationDetailData {get;set;}
    public List <NotifRemark> notifRemarkList {get;set;}
    
    public List <AssessmentSummary> assessmentSummaryUWList {get;set;}
    public List <AssessmentDetail> assessmentDetailUWList {get;set;}
    public String assDetailRefNo {get;set;}
    
    public List <Case> RHSList {get;set;}
    public List <Case> CHSList {get;set;}
    public List <Case> InquiryList {get;set;}
    
    public Boolean flagShow {get;set;}
    
    //Pagination
    public integer indexRHS {get;set;}
    public integer indexCHS {get;set;}
    public integer indexInquiry {get;set;}
    public integer blockSize {get;set;}
    public Integer pageOfRHS {get;set;}
    public Integer pageOfCHS {get;set;}
    public Integer pageOfInquiry {get;set;}
    public Integer allPageRHS {get;set;}
    public Integer allPageCHS {get;set;}
    public Integer allPageInquiry {get;set;}
    Public Integer allDataSizeRHS {get; set;}
    Public Integer allDataSizeCHS {get; set;}
    Public Integer allDataSizeInquiry {get; set;}
    public List <Case> paginationCase {get;set;}
    Public Integer tempCaseListSize {get;set;}
    
    //Constractor
    public SearchPolicyNoAFI(){
        indexRHS = 0;
        indexCHS = 0;
        indexInquiry = 0;
        blockSize = 10;
        pageOfRHS = 0;
        pageOfCHS = 0;
        pageOfInquiry = 0;
        allPageRHS = 0;
        allPageCHS = 0;
        allPageInquiry = 0;
        tempCaseListSize = 0;
    }
    
    public class AppDetail {
        public Date PolicyEffectiveDate {get; set;}
        public String PartyCode {get; set;}
        public String ServicingCode {get; set;}
        public String PaymentMethodCode {get; set;}
        public Date PolicyExpirationDate {get; set;}
        public Decimal InitialLumpsumPremium {get; set;}
        public String CurrencyCode {get; set;}
        public Date StartPremiumHolidayDate {get; set;}
        public Date EndPremiumHolidayDate {get; set;}
        public Date ApplicationDate {get; set;}
        public String PlanCode {get; set;}
        public String InsuranceProductRemark {get; set;}
        public Decimal SumInsured {get; set;}
        public String PlanName {get; set;}
        public String InsuranceProductCode {get; set;}
        public String TopupRegularModalPremium {get; set;}
        public String PolicyStatusCode {get; set;}
        public Date TerminationDate {get; set;}
        public String GdbValue {get; set;}
        public String DividendAmt {get; set;}
        public String FuturePremiumDpIntTypeCode {get; set;}
        public Decimal LoanRepayment {get; set;}
        public Decimal FuturePremiumDp {get; set;}
        public String LoanIntTypeCode {get; set;}
        public String DividendTypeCode {get; set;}
        public Date PolicyDueDate {get; set;}
        public Decimal Premium {get; set;}
        public String PaymentModeCD {get; set;}
        public String InsuredID {get; set;}
        public String GenderCode {get; set;}
        public String EmailAddress {get; set;}
        public String MobilePhoneNO {get; set;}
        public String LastName {get; set;}
        public String MiddleName {get; set;}
        public String FirstName {get; set;}
        public String BirthPlace {get; set;}
        public Date BirthDate {get; set;}
        public String SourceChannelCode {get; set;}
        public Date IssueDate {get; set;}
        public String OwnerName {get; set;}
        public Date OwnerBirthDate {get; set;}
        public String OwnerBirthPlace {get; set;}
        public String OwnerGenderCode {get; set;}
        public String OwnerIdentifyNo {get; set;}
        public String OwnerEmailAddress {get; set;}
        public String OwnerMobilePhoneNO {get; set;}
        
        
        public AppDetail(){
            
        }
    }
    
    public class NotifRemark {
        public String AssessmentSection {get; set;}
        public String AssessmentStatus {get; set;}
        public String AssessmentRemark {get; set;}
        public String AssessmentReferenceNo {get; set;}
        public String AssessmentTypeCode {get; set;}
        public String LastUpdateBy {get; set;}
        public Date LastUpdateDate {get; set;}
        public Date AssessorDate {get; set;}
        
        public NotifRemark(){
            
        }
    }
    
    public class  AssessmentSummary{
        public Datetime LastInputDateTime {get; set;}
        public string Section {get; set;}
        public string TranTypeClaimType {get; set;}
        public string RefNo {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}
        public string assessmentClassType {get; set;}
        
               
        public AssessmentSummary(){
        }       
    }
    
    public class  AssessmentDetail{
        public Datetime InputDateTime {get; set;}
        public string UserIDAssessment {get; set;}
        public string Description {get; set;}
        public string Section {get; set;} 
        public string assessmentClassType {get; set;}
               
        public AssessmentDetail(){
        }       
    }
    
    public void selectedPolicyNo(){
        
        DateTime dtStart = DateTime.now();
        
        system.debug ('>>> selectedPolicyNo is begin ..');
        
        system.debug('searchPolicyNo: '+searchPolicyNo);
        
        try{
            //Contact con = [SELECT Id, Name, MobilePhone, Email, Policy_No__c, PolicyApp__c, Entity__c FROM Contact WHERE Entity__c = 'AFI' AND Policy_No__c =: searchPolicyNo];
            
            if(searchPolicyNo != null){
                flagShow = TRUE;
                system.debug ('flagShow = TRUE');
            } else {
                flagShow = FALSE;
                system.debug ('flagShow = FALSE');
            }
        } catch(Exception e){
            flagShow = FALSE;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Policy No tidak ditemukan. Mohon periksa kembali.'));
        }
        
        getApplicationDetailList();
        getNotificationRemarkList();
        getAssSummaryList();
        //getAssDetailList();
        
        
        //String[] filters_policyNo = new String[]{'acme%','ib%'};
        String filter_policyNo = '%'+searchPolicyNo+'%';
        RHSList = new List<Case>();
        CHSList = new List<Case>();
        InquiryList = new List<Case>();
        /*
        RHSList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Request' AND Subject LIKE :filter_policyNo ORDER BY CreatedDate DESC LIMIT 1000];
        CHSList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Complaint' AND Subject LIKE :filter_policyNo ORDER BY CreatedDate DESC LIMIT 1000];
        InquiryList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Inquiry' AND Subject LIKE :filter_policyNo ORDER BY CreatedDate DESC LIMIT 1000];
		*/
        
        /*List<Case> allData = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE (Type = 'Request' OR Type = 'Complaint' OR Type = 'Inquiry') AND Subject LIKE :filter_policyNo ORDER BY CreatedDate DESC LIMIT 1000];
        for(Case cs : allData){
            if(cs.Type == 'Request'){
                RHSList.add(cs);
            } else if(cs.Type == 'Complaint'){
                CHSList.add(cs);
            } else if(cs.Type == 'Inquiry'){
                InquiryList.add(cs);
            }
        }
        
        allDataSizeRHS = RHSList.size();
        allDataSizeCHS = CHSList.size();
        allDataSizeInquiry = InquiryList.size();
        
        system.debug('filter_policyNo: '+filter_policyNo);
        system.debug('RHSList: '+RHSList);
        system.debug('RHSList (Size): '+RHSList.size());
        system.debug('CHSList: '+CHSList);
        system.debug('CHSList (Size): '+CHSList.size());
        system.debug('InquiryList: '+InquiryList);
        system.debug('InquiryList (Size): '+InquiryList.size());*/
        
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== POLICY INFO PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
        
    }
    
    public void initAssDet(){
        system.debug ('>>> Assessment Detail is begin ..');
        
        String tempPolicyNo = Apexpages.currentPage().getUrl().substringAfter('policyNo=');
        system.debug('tempPolicyNo: '+tempPolicyNo);
        
        if(tempPolicyNo.contains('&')){ searchPolicyNo = tempPolicyNo.substringBefore('&'); }
        else { searchPolicyNo = tempPolicyNo; }
        system.debug('searchPolicyNo: ' + searchPolicyNo);
        
        system.debug('=================================');
        
        String tempRefNo = Apexpages.currentPage().getUrl().substringAfter('refNo=');
        system.debug('tempRefNo: '+tempRefNo);
        if(tempRefNo.contains('&')){ assDetailRefNo = tempRefNo.substringBefore('&'); }
        else { assDetailRefNo = tempRefNo; }
        system.debug('assDetailRefNo: ' + assDetailRefNo);
        
        system.debug('=================================');
        
        getAssDetailList();
    }
    
    public void initIssuedInfo(){
        system.debug ('>>> initIssuedInfo is begin ..');
        
        String tempPolicyNo = Apexpages.currentPage().getUrl().substringAfter('policyNo=');
        system.debug('tempPolicyNo: '+tempPolicyNo);
        
        if(tempPolicyNo.contains('&')){ searchPolicyNo = tempPolicyNo.substringBefore('&'); }
        else { searchPolicyNo = tempPolicyNo; }
        system.debug('searchPolicyNo: ' + searchPolicyNo);
        
        getApplicationDetailList();
        getNotificationRemarkList();
        getAssSummaryList();
        
        String filter_policyNo = '%'+searchPolicyNo+'%';
        RHSList = new List<Case>();
        CHSList = new List<Case>();
        InquiryList = new List<Case>();
    }
    
    public void initRHSInfo(){
        system.debug ('>>> initRHSInfo is begin ..');
        
        String tempPolicyNo = Apexpages.currentPage().getUrl().substringAfter('policyNo=');
        system.debug('tempPolicyNo: '+tempPolicyNo);
        
        if(tempPolicyNo.contains('&')){ searchPolicyNo = tempPolicyNo.substringBefore('&'); }
        else { searchPolicyNo = tempPolicyNo; }
        system.debug('searchPolicyNo: ' + searchPolicyNo);
        
        String filter_policyNo = '%'+searchPolicyNo+'%';
        RHSList = new List<Case>();
        
        RHSList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Request' AND Subject LIKE :filter_policyNo AND Entity_Backup__c = 'AFI' ORDER BY CreatedDate DESC LIMIT 5];
        allDataSizeRHS = RHSList.size();
        system.debug('RHSList: '+RHSList);
        system.debug('RHSList (Size): '+allDataSizeRHS);
    }
    
    public void initCHSInfo(){
        system.debug ('>>> initCHSInfo is begin ..');
        
        String tempPolicyNo = Apexpages.currentPage().getUrl().substringAfter('policyNo=');
        system.debug('tempPolicyNo: '+tempPolicyNo);
        
        if(tempPolicyNo.contains('&')){ searchPolicyNo = tempPolicyNo.substringBefore('&'); }
        else { searchPolicyNo = tempPolicyNo; }
        system.debug('searchPolicyNo: ' + searchPolicyNo);
        
        String filter_policyNo = '%'+searchPolicyNo+'%';
        CHSList = new List<Case>();
        
        CHSList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Complaint' AND Subject LIKE :filter_policyNo AND Entity_Backup__c = 'AFI' ORDER BY CreatedDate DESC LIMIT 5];
    	allDataSizeCHS = CHSList.size();
        system.debug('CHSList: '+CHSList);
        system.debug('CHSList (Size): '+allDataSizeCHS);
    }
    
    public void initInquiryInfo(){
        system.debug ('>>> initInquiryInfo is begin ..');
        
        String tempPolicyNo = Apexpages.currentPage().getUrl().substringAfter('policyNo=');
        system.debug('tempPolicyNo: '+tempPolicyNo);
        
        if(tempPolicyNo.contains('&')){ searchPolicyNo = tempPolicyNo.substringBefore('&'); }
        else { searchPolicyNo = tempPolicyNo; }
        system.debug('searchPolicyNo: ' + searchPolicyNo);
        
        String filter_policyNo = '%'+searchPolicyNo+'%';
        InquiryList = new List<Case>();
        
        InquiryList = [SELECT Id, CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type = 'Inquiry' AND Subject LIKE :filter_policyNo AND Entity_Backup__c = 'AFI' ORDER BY CreatedDate DESC LIMIT 5];
    	allDataSizeInquiry = InquiryList.size();
        system.debug('InquiryList: '+InquiryList);
        system.debug('InquiryList (Size): '+allDataSizeInquiry);
    }
    
    
    
    //APPLICATION DETAIL
    public String getApplicationDetailList(){
        try {
            EIPJson eipAppDetail = new EIPJson();
            string policyApp = '';
            
            if(searchPolicyNo != null){
                //Contact con = [SELECT Id, Name, MobilePhone, Email, Policy_No__c, PolicyApp__c, Entity__c FROM Contact WHERE Entity__c = 'AFI' AND Policy_No__c =: searchPolicyNo];
                //policyApp = con.PolicyApp__c;
                
                eipAppDetail = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_APP_DETAIL, 'AFI', 'RLS', searchPolicyNo, true);
                system.debug('eipAppDetail: '+eipAppDetail);
            } else {
                system.debug('===== Policy No is blank =====');
            }
            
            applicationDetailData = new AppDetail();
            
            //Integer countAppDetailList = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
            //system.debug('countAppDetailList: '+countAppDetailList);
            //for(Integer i=0; i < countAppDetailList; i++) {
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM != '00000000'){ 
                    applicationDetailData.PolicyEffectiveDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].partyCD != null){
                    applicationDetailData.PartyCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].partyCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD != null){
                    applicationDetailData.ServicingCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn[0].servicingCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].paymentMethodCD != null){
                    applicationDetailData.PaymentMethodCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].paymentMethodCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyExpirationDTTM != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyExpirationDTTM != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyExpirationDTTM != '00000000'){ 
                    applicationDetailData.PolicyExpirationDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyExpirationDTTM, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].initialLumpsumPremiumAMT != null){
                    applicationDetailData.InitialLumpsumPremium = CCCUtils.strToDec(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].initialLumpsumPremiumAMT);
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].currencyCD != null){
                    applicationDetailData.CurrencyCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].currencyCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].startPremiumHolidayDT != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].startPremiumHolidayDT != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].startPremiumHolidayDT != '00000000'){ 
                    applicationDetailData.StartPremiumHolidayDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].startPremiumHolidayDT, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].endPremiumHolidayDT != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].endPremiumHolidayDT != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].endPremiumHolidayDT != '00000000'){ 
                    applicationDetailData.EndPremiumHolidayDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasLifePolicyChangeTransDetailsIn[0].endPremiumHolidayDT, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM != '00000000'){ 
                    applicationDetailData.ApplicationDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasApplicationDetailsIn[0].applicationDTTM, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planCd != null){
                    applicationDetailData.PlanCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planCd;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].insuranceProductRk != null){
                    applicationDetailData.InsuranceProductRemark = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].insuranceProductRk;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured != null){
                    applicationDetailData.SumInsured = CCCUtils.strToDec(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].hasPolicySegmentDetailsIn[0].sumInsured);
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM != null){
                    applicationDetailData.PlanName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM != null){
                    applicationDetailData.PlanName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].planNM;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].insuranceProductCd != null){
                    applicationDetailData.InsuranceProductCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithLifeInsuranceProduct[0].insuranceProductCd;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium != null){
                    applicationDetailData.TopupRegularModalPremium = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].topupRegularModalPremium;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD != null){
                    applicationDetailData.PolicyStatusCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].terminationDt != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].terminationDt != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].terminationDt != '00000000'){ 
                    applicationDetailData.TerminationDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].terminationDt, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].gdbValue != null){
                    applicationDetailData.GdbValue = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].gdbValue;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].dividendAmt != null){
                    applicationDetailData.DividendAmt = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].dividendAmt;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].futurePremiumDpIntTypeCode != null){
                    applicationDetailData.FuturePremiumDpIntTypeCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].futurePremiumDpIntTypeCode;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].loanRepaymentAmt != null){
                    applicationDetailData.LoanRepayment = CCCUtils.strToDec(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].loanRepaymentAmt);
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].futurePremiumDpAmt != null){
                    applicationDetailData.FuturePremiumDp = CCCUtils.strToDec(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].futurePremiumDpAmt);
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].loanIntTypeCd != null){
                    applicationDetailData.LoanIntTypeCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].loanIntTypeCd;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].dividendTypeCD != null){
                    applicationDetailData.DividendTypeCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyIn[0].dividendTypeCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyDueDt != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyDueDt != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyDueDt != '00000000'){ 
                    applicationDetailData.PolicyDueDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyDueDt, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT != null){
                    applicationDetailData.Premium = CCCUtils.strToDec(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT);
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].paymentModeCD != null){
                    applicationDetailData.PaymentModeCD = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].paymentModeCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID != null){
                    applicationDetailData.InsuredID = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].genderCD != null){
                    applicationDetailData.GenderCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].genderCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].hasAddressesIn[0].emailAddress != null){
                    applicationDetailData.EmailAddress = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].hasAddressesIn[0].emailAddress;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].hasAddressesIn[0].mobilePhoneNO != null){
                    applicationDetailData.MobilePhoneNO = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].hasAddressesIn[0].mobilePhoneNO;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM != null){
                    applicationDetailData.LastName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].lastNM;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].middleNM != null){
                    applicationDetailData.MiddleName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].middleNM;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM != null){
                    applicationDetailData.FirstName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].firstNM;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthPlace != null){
                    applicationDetailData.BirthPlace = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthPlace;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT != '00000000'){ 
                    applicationDetailData.BirthDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].birthDT, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD != null){
                    applicationDetailData.SourceChannelCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueDt != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueDt != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueDt != '00000000'){ 
                    applicationDetailData.IssueDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueDt, 'yyyymmdd');
                }
                
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.firstNM != null){
                    applicationDetailData.OwnerName = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.firstNM;
                }
                
            	if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT != null && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT != '99999999' && eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT != '00000000'){ 
                    applicationDetailData.OwnerBirthDate = (date) CCCUtils.strToDate(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT, 'yyyymmdd');
                }
            	
            	if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthPlace != null){
                    applicationDetailData.OwnerBirthPlace = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthPlace;
                }
            	
                if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.genderCD != null){
                    applicationDetailData.OwnerGenderCode = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.genderCD;
                }
            	
            	if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.socialSecurityNO != null){
                    applicationDetailData.OwnerIdentifyNo = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.socialSecurityNO;
                }
            	
            	if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].emailAddress != null){
                    applicationDetailData.OwnerEmailAddress = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].emailAddress;
                }
            	
            	if(eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO != null){
                    applicationDetailData.OwnerMobilePhoneNO = eipAppDetail.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO;
                }
                
            //}
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    //END - APPLICATION DETAIL
	
	    
	//NOTIFICATION REMARK
    public String getNotificationRemarkList(){
        try {
            EIPJson eipNotifRemark = new EIPJson();
            string policyApp = '';
            
            if(searchPolicyNo != null){
                //Contact con = [SELECT Id, Name, MobilePhone, Email, Policy_No__c, PolicyApp__c, Entity__c FROM Contact WHERE Entity__c = 'AFI' AND Policy_No__c =: searchPolicyNo];
                //policyApp = con.PolicyApp__c;
                
                eipNotifRemark = EIPConnector.getAssNotes(EIPConstant.OPERATION_NOTIF_REMARK, 'AFI', 'RLS', searchPolicyNo, EIPConstant.ASSESSMENT_TYPE_UW, null, null);
                system.debug('eipNotifRemark: '+eipNotifRemark);
            } else {
                system.debug('===== Policy No is blank =====');
            }
            
            notifRemarkList = new List<NotifRemark>();
            
            Integer countNotifactionRemarkList = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn.size();
            system.debug('countNotifactionRemarkList: '+countNotifactionRemarkList);
            for(Integer i=0; i < countNotifactionRemarkList; i++) {
                NotifRemark ntf_remark = new NotifRemark();
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection != null){ 
                    ntf_remark.AssessmentSection = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtStatus != null){ 
                    ntf_remark.AssessmentStatus = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtStatus;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRemark != null){ 
                    ntf_remark.AssessmentRemark = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRemark;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRefNo != null){ 
                    ntf_remark.AssessmentReferenceNo = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRefNo;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtTypeCd != null){ 
                    ntf_remark.AssessmentTypeCode = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtTypeCd;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdBy != null){ 
                    ntf_remark.LastUpdateBy = eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdBy;
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM != null && eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM != '99999999' && eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM != '00000000'){ 
                    ntf_remark.LastUpdateDate = (date) CCCUtils.strToDate(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM, 'yyyymmdd');
                }
                
                if(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessorDTTM != null && eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessorDTTM != '99999999' && eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessorDTTM != '00000000'){ 
                    ntf_remark.AssessorDate = (date) CCCUtils.strToDate(eipNotifRemark.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessorDTTM, 'yyyymmdd');
                }
				
                notifRemarkList.add(ntf_remark);
            }
            system.debug('notifRemarkList: '+notifRemarkList);
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    //END - NOTIFICATION REMARK
    
    
    //ASSESSMENT SUMMARY
    public String getAssSummaryList(){
        try {
            EIPJson eipAssSummUW = new EIPJson();
            string policyApp = '';
            
            if(searchPolicyNo != null){
                //Contact con = [SELECT Id, Name, MobilePhone, Email, Policy_No__c, PolicyApp__c, Entity__c FROM Contact WHERE Entity__c = 'AFI' AND Policy_No__c =: searchPolicyNo];
                //policyApp = con.PolicyApp__c;
                
                eipAssSummUW = EIPConnector.getAssNotes(EIPConstant.OPERATION_SUMMARY, 'AFI', 'RLS', searchPolicyNo, EIPConstant.ASSESSMENT_TYPE_UW, null, null);
                system.debug('eipAssSummUW: '+eipAssSummUW);
            } else {
                system.debug('===== Policy No is blank =====');
            }
            
            assessmentSummaryUWList = new List<AssessmentSummary>();
            
            Integer countAssSummUWList = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn.size();
            system.debug('countAssSummUWList: '+countAssSummUWList);
            for(Integer i=0; i < countAssSummUWList; i++) {
                AssessmentSummary assUW = new AssessmentSummary();
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM != null){ 
                    assUW.LastInputDateTime = CCCUtils.strToDateTime(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM, 'yyyymmddhhmmss');
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection != null){ 
                    assUW.Section = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection;
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtTypeCd != null){ 
                    assUW.TranTypeClaimType = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtTypeCd;
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRefNo != null){ 
                    assUW.RefNo = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRefNo;
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtStatus != null){ 
                    assUW.Status = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtStatus;
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRemark != null){ 
                    assUW.Remark = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtRemark;
                }
                
                if(eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessmentClassType != null){ 
                    assUW.assessmentClassType = eipAssSummUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessmentClassType;
                }
				
                assessmentSummaryUWList.add(assUW);
            }
            system.debug('assessmentSummaryUWList: '+assessmentSummaryUWList);
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    //END - ASSESSMENT SUMMARY
    
    
    //ASSESSMENT DETAIL
    public String getAssDetailList(){
        try {
            EIPJson eipAssDetUW = new EIPJson();
            string policyApp = '';
            
            if(searchPolicyNo != null){
                eipAssDetUW = EIPConnector.getAssNotes(EIPConstant.OPERATION_DETAIL, 'AFI', 'RLS', searchPolicyNo, EIPConstant.ASSESSMENT_TYPE_UW, assDetailRefNo, null); system.debug('eipAssDetUW: '+eipAssDetUW);
            } else {
                system.debug('===== Policy No is blank =====');
            }
            
            assessmentDetailUWList = new List<AssessmentDetail>();
            
            Integer countAssDetUWList = eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn.size();
            system.debug('countAssDetUWList: '+countAssDetUWList);
            for(Integer i=0; i < countAssDetUWList; i++) {
                AssessmentDetail assDetUW = new AssessmentDetail();
                
                if(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM != null){ assDetUW.InputDateTime = CCCUtils.strToDateTime(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdDTTM, 'yyyymmddhhmmss');
                }
                
                if(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdBy != null){ assDetUW.UserIDAssessment = eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].lastUpdBy;
                }
                
                if(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtDesc != null){ assDetUW.Description = eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtDesc.replaceAll('\\n','<br/>').replace(' ','&nbsp;');
                }
				                
                if(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection != null){ assDetUW.Section = eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assmtSection;
                }
                
                if(eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessmentClassType != null){ assDetUW.assessmentClassType = eipAssDetUW.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[i].assessmentClassType;
                }
				
                assessmentDetailUWList.add(assDetUW);
            }
            system.debug('assessmentDetailUWList: '+assessmentDetailUWList);
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    //END - ASSESSMENT DETAIL
    
    
    public Double offset{
        get{
            TimeZone tz = UserInfo.getTimeZone();
            //Milliseconds to Day
            return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
        }
    }
    
    /*
    //coba pagination RHS   
    public void beginningRHS(){
        indexRHS = 0;
    }
    
    public void previousRHS(){
        indexRHS = indexRHS - blockSize;
    }
    
    public void nextRHS()
    {
        indexRHS = indexRHS + blockSize;
    }
    
    public void endRHS(){
        indexRHS = allDataSizeRHS - math.mod(allDataSizeRHS,blockSize);
    }
    
    public boolean getprevRHS(){
        if(indexRHS == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxtRHS(){
        if((indexRHS + blockSize) >= allDataSizeRHS)
            return true;
        else
            return false;
    }
    
    //coba pagination CHS   
    public void beginningCHS(){
        indexCHS = 0;
    }
    
    public void previousCHS(){
        indexCHS = indexCHS - blockSize;
    }
    
    public void nextCHS()
    {
        indexCHS = indexCHS + blockSize;
    }
    
    public void endCHS(){
        indexCHS = allDataSizeCHS - math.mod(allDataSizeCHS,blockSize);
    }
    
    public boolean getprevCHS(){
        if(indexCHS == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxtCHS(){
        if((indexCHS + blockSize) >= allDataSizeCHS)
            return true;
        else
            return false;
    }
    
    //coba pagination Inquiry   
    public void beginningInquiry(){
        indexInquiry = 0;
    }
    
    public void previousInquiry(){
        indexInquiry = indexInquiry - blockSize;
    }
    
    public void nextInquiry()
    {
        indexInquiry = indexInquiry + blockSize;
    }
    
    public void endInquiry(){
        indexInquiry = allDataSizeInquiry - math.mod(allDataSizeInquiry,blockSize);
    }
    
    public boolean getprevInquiry(){
        if(indexInquiry == 0)
            return true;
        else
            return false;
    }
    
    public boolean getnxtInquiry(){
        if((indexInquiry + blockSize) >= allDataSizeInquiry)
            return true;
        else
            return false;
    }
    
    public List<case> getRHSListPage(){
        if(searchPolicyNo == Null || searchPolicyNo == ''){
            pageOfRHS = 0;
            allPageRHS = 0;
            allDataSizeRHS = 0;
        } else {
            pageOfRHS = indexRHS/BlockSize + 1;
            allPageRHS = (allDataSizeRHS/BlockSize) + 1;
        }
        paginationCase = new List<Case>();
        //selectedPolicyNo();
        List<Case> temp = new List<Case>();
        temp = RHSList;
        tempCaseListSize = temp.size();
        Integer endblock = blockSize + indexRHS;
        if(endblock>=tempCaseListSize) endblock = tempCaseListSize;
        for(Integer i = indexRHS ; i < endblock ; i++){
            paginationCase.add(temp.get(i));
        }
        
        tempCaseListSize = paginationCase.size();
        
        return paginationCase;
    }
    
    public List<case> getCHSListPage(){
        if(searchPolicyNo == Null || searchPolicyNo == ''){
            pageOfCHS = 0;
            allPageCHS = 0;
            allDataSizeCHS = 0;
        } else {
            pageOfCHS = indexCHS/BlockSize + 1;
            allPageCHS = (allDataSizeCHS/BlockSize) + 1;
        }
        paginationCase = new List<Case>();
        //selectedPolicyNo();
        List<Case> temp = new List<Case>();
        temp = CHSList;
        tempCaseListSize = temp.size();
        Integer endblock = blockSize + indexCHS;
        if(endblock>=tempCaseListSize) endblock = tempCaseListSize;
        for(Integer i = indexCHS ; i < endblock ; i++){
            paginationCase.add(temp.get(i));
        }
        
        tempCaseListSize = paginationCase.size();
        
        return paginationCase;
    }
    
    public List<case> getInquiryListPage(){
        if(searchPolicyNo == Null || searchPolicyNo == ''){
            pageOfInquiry = 0;
            allPageInquiry = 0;
            allDataSizeInquiry = 0;
        } else {
            pageOfInquiry = indexInquiry/BlockSize + 1;
            allPageInquiry = (allDataSizeInquiry/BlockSize) + 1;
        }
        paginationCase = new List<Case>();
        //selectedPolicyNo();
        List<Case> temp = new List<Case>();
        temp = InquiryList;
        tempCaseListSize = temp.size();
        Integer endblock = blockSize + indexInquiry;
        if(endblock>=tempCaseListSize) endblock = tempCaseListSize;
        for(Integer i = indexInquiry ; i < endblock ; i++){
            paginationCase.add(temp.get(i));
        }
        
        tempCaseListSize = paginationCase.size();
        
        return paginationCase;
    }*/
}