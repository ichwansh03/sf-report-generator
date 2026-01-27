public class PolicyDetailControllerALI {

    public string bacaString(string datanya){
        string balikan = '';
        
        try{
            balikan=datanya;
            //balikan=balikan.trim();
            system.debug('Balikan sukses: \''+balikan+'\'');
        }catch(exception ex){
            system.debug('Balikan error dari WSDL: ' + ex.getMessage());
            balikan = '';
        }
        return balikan;
    }
    
    public decimal bacaDecimal(decimal datanya){
        decimal balikan=0;
        
        try{
            balikan=datanya;
            system.debug('Balikan sukses: '+balikan);
        }catch(exception ex){
            system.debug('Balikan error dari WSDL = ' + ex.getMessage());
            balikan=0;
        }
        return balikan;
    }
    
    public integer bacaInteger(integer datanya){
        integer balikan=0;
        
        try{
            balikan=datanya;
            system.debug('Balikan sukses: '+balikan);
        }catch(exception ex){
            system.debug('Balikan error dari WSDL = ' + ex.getMessage());
            balikan=0;
        }
        return balikan;
    }
    
    
    public Double bacaDouble(Double datanya){
        Double balikan=0;
        
        try{
            balikan=datanya;
            system.debug('Balikan sukses: '+balikan);
        }catch(exception ex){
            system.debug('Balikan error dari WSDL = ' + ex.getMessage());
            balikan=0;
        }
        return balikan;
    }
    
    public string policyNo {get; set;}
    public string entity {get; set;}
    public string policyApp {get; set;}
    public string token {get; set;}
    
    public Customer pelanggan {get;set;}
    public Agent agen {get;set;}
    public PolicyRider polisRider {get;set;}
    public List<Insured> insuredList {get;set;}
    public List<Beneficiary> beneficiaryList {get;set;}
    public List<TrxPayment> trxPaymentList {get;set;}
    public List<TrxPayment> trxPaymentList5 {get;set;}
    public List<TrxClaim> trxClaimList {get;set;}
    public List<TrxClaim> trxClaimList5 {get;set;}
    public List<TrxClaim> trxOpenLastClaimList {get;set;}
    // new ALI
    public List<TrxRHS> trxRHSList {get;set;}
    public List<TrxRHS> trxOpenLastRHSList {get;set;}
    public List<TrxCallNote> trxBackEndRHSList {get;set;}
    public List<TrxCallNote> trxBackEndRHSList5 {get;set;}

    public List<TrxCHS> trxCHSList {get;set;}
    public List<TrxCHS> trxOpenLastCHSList {get;set;}
    public List<TrxCallNote> trxBackEndCHSList {get;set;}

    public List<TrxInquiry> trxInquiryList {get;set;}
    public List<TrxInquiry> trxOpenLastInquiryList {get;set;}
    public List<TrxCallNote> trxBackEndInquiryList {get;set;}

    public List<FPAPolicy> FPAPolicyList {get;set;}
    public List<FPABeneficiary> FPABeneficiaryList {get;set;}

    public List<TrxPayment> trxPayInfoList {get;set;}
    public List<TrxPolicyHistory> TrxPolicyHistoryList {get;set;}
    public List<TrxPolicyHistory> TrxPolicyHistoryList5 {get;set;}
    public List<BackEndPaging__c> trxBEP {get;set;}
    // end New ALI
    
    public List<GIClaim> giClaimList {get;set;}
    public List<GIEndorsement> giEndorsementList {get;set;}
    public List<DetailFund> detailFundList {get;set;}
    public List<FundTransaction> fundTrxList {get;set;}
    public List<PremiumBreakdown> premiumBreakdownList {get;set;}
    public List<PolicyChange> policyChangeList {get;set;}
    public List<TableofContent> TOCList {get;set;}
    public List<AccountDetail> accountDetailList {get;set;}
    public List<PremiumDetail> premiumDetailList {get;set;}
    public List<InterestInfo> interestInfoList {get;set;}
    public DetailFund detailFund {get;set;}
    public List<CashValueDetail> cashValueList {get;set;}
    public boolean isDisplayed {get;set;}
    public boolean displayRLSOnly {get;set;}
    public boolean displayGIOnly {get;set;}
    public boolean AdditionalNonRLS {get;set;}
    public String tipe {get;set;}
    public String contactId {get;set;}
    public Integer panjang {get;set;}
    public String errorDSRTN {get;set;}
    public String val1 {get;set;}
    public String val2 {get;set;}
    public String val3 {get;set;}
    public String val4 {get;set;}
    public String val5 {get;set;}
    public String val6 {get;set;}
    public String val7 {get;set;}
    public String val8 {get;set;}
    public String val9 {get;set;}
    public String val10 {get;set;}
    public String valph {get;set;}
    public CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsRLS ambilRLS {get;set;}
    public CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsNonRLSALI ambilNonRLSALI {get;set;}
    public CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsGI ambilGI {get;set;}
    //public CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsGI ambilGI {get;set;}
    
    public class Customer {
        public string CustomerID {get; set;}
        public string Name    {get; set;}
        public string PlaceOfBirth  {get; set;}
        public date  DOB {get; set;}
        public string Gender  {get; set;}
        public string Alamat1  {get; set;}
        public string Alamat2  {get; set;}
        public string Alamat3  {get; set;}
        public string Alamat4  {get; set;}
        public string EmailAddress   {get; set;}
        public string MobilePhoneNumber {get; set;}
        public string AgentServicing   {get; set;}
        public string AgentProducer {get; set;}
        // new ALI
        public string MobilePhone2 {get; set;}
        public string IdentityNo {get; set;}
        public string IdentityTypeID {get; set;}
        public date BlacklistDate {get; set;}        

        public string ZipCode {get; set;}
        public string City {get; set;}
        public string Province {get; set;}
        public date Paidtodate {get; set;}
        public string CardNo {get; set;}
        public string AccountNo {get; set;}
        public string CardName {get; set;}
        public string AccountName{get; set;}
        public string BankName{get; set;}
        public string CardExpire {get; set;}

        public decimal TotalNotPaid {get; set;}
        public integer CountPayment {get; set;}
        public integer CountPaid {get; set;}
        public integer CountNotPaid {get; set;}
        public integer CountClaim {get; set;}
        public integer CountSFDC_CN {get; set;}
        public integer CountSFDC_PH {get; set;}
        public integer CountSFDC_Payment {get; set;}

        public Customer(){
        }       
    }

    public class Agent {
        public string AgentNo    {get; set;}
        public string Entity    {get; set;}
        public string DistributionCode    {get; set;}
        public string DistributionType    {get; set;}
        public string AgentName    {get; set;}
        public string AgentID   {get; set;}
        public date  JoinDate    {get; set;}
        public string  Status  {get; set;}
        public string Area    {get; set;}
        public string HomeAddress1  {get; set;}
        public string HomeAddress2  {get; set;}
        public string HomeAddress3  {get; set;}
        public string HomeAddress4  {get; set;}
        public string OfficeAddress1  {get; set;}
        public string OfficeAddress2  {get; set;}
        public string OfficeAddress3  {get; set;}
        public string OfficeAddress4  {get; set;}
        public string EmailAddress   {get; set;}
        public string HomePhone1   {get; set;}
        public string HomePhone2   {get; set;}
        public string OfficePhone {get; set;}
        public string MobilePhone1 {get; set;}
        public string MobilePhone2 {get; set;}
        public string Fax1 {get; set;}
        public string Fax2 {get; set;}
        public string City {get; set;}
        public string TOC {get; set;}
        public string ZipCode {get; set;}
        public string ContactPerson {get; set;}
        public string ContactAddress {get; set;}
        public string ContactPhone {get; set;}
        public string A_Type {get;set;}
        public string C_Type {get;set;}
        public string P_Type {get;set;}
        public string MO_Code {get;set;}
        public string MO_Name {get;set;}
        public string UserID {get;set;}
        public string CPOLICYNO {get;set;}
        public string PHOLDER {get;set;}
        public string CT {get;set;}
        public string ConjunctionF {get;set;}
        public string Description1 {get;set;}
        public string ID {get;set;}
        public string Salutation {get;set;}
        public string FirstName {get;set;}
        public string MidName {get;set;}
        public string LastName {get;set;}
        public string Name2 {get;set;}
        public string Email1 {get;set;}
        public string Email_2 {get;set;}
        public string Title {get;set;}
        
        public Agent(){
        }       
    }
    
    public class PolicyRider {
        public string PolicyNumber   {get; set;}
        public string MataUang    {get; set;}
        public string ReferenceNumber    {get; set;}
        public string ProductCode    {get; set;}
        public string ProductName    {get; set;}
        public string PolicyStatus   {get; set;}
        public date  DateofApplication {get; set;}
        public date  IssuedDate  {get; set;}
        public date  EffectiveDate   {get; set;}
        public string  EffectiveStatus   {get; set;}
        public date  ExpiredDate     {get; set;}
        public date  TerminationDate     {get; set;}
        public date  ReferenceDate     {get; set;}
        public decimal TotalPremium   {get; set;}
        public decimal TotalSumInsured   {get; set;}
        public string Description {get; set;}
        public decimal TotalPremiumofBasicPlan {get; set;}
        public decimal  BasicSI   {get; set;}
        public decimal  RegularTopUp  {get; set;}
        public decimal  LumpSumTopUp {get; set;}
        public decimal BasicRiderModPrem {get; set;}
        public decimal BasicRegPrem {get;set;}
        public string PaymentMethod    {get; set;}
        public string PaymentMode    {get; set;}
        public date DueDate1   {get; set;}
        public date DueDate2 {get; set;}
        public date PremiumHolidayStart {get; set;}
        public date PremiumHolidayEnd {get; set;}
        public string  FundPrice  {get; set;}
        public decimal CashValue  {get; set;}
        public string StatusDesc  {get; set;}
        public string CoverNo {get; set;}
        public string Segment {get; set;}
        public string Branch  {get; set;}
        public string BranchCode  {get; set;}
        public string Insured  {get; set;}
        public date StartDate {get; set;}
        public date EndDate {get; set;}
        public date CoverDate {get;set;}
        public date PolicyDate {get;set;}
        public string USPRRLTN  {get; set;}
        public decimal TSI {get; set;}
        public decimal PremiumGI {get; set;}

        public string TSIS {get; set;}          //added by WK, 20151112 : quickwins 2
        public string PremiumGIS {get; set;}    //added by WK, 20151112 : quickwins 2
        public string AIDS {get; set;}          //added by WK, 20151112 : quickwins 2
        
        // new ALI
        public date CancelDate  {get; set;}
        public date LapseDate  {get; set;}
        public date ReinstateDate  {get; set;}
        public string SponsorName  {get; set;}
        public string CorrespondenceTypeID  {get; set;}
        public string CampaignProgramName  {get; set;}
        public date CreateDate  {get; set;}
        public string DigitaPolicyID  {get; set;}
        public string AgentID  {get; set;}        
        
        public PolicyRider(){
        }       
    }    

    public class Insured{
        public string Name    {get; set;}
        public string PlaceofBirth  {get; set;}
        public date DOB {get; set;}
        public string Gender  {get; set;}
        public string RelationwithPolicyHolder {get; set;}
        public string IdentificationNo   {get; set;}
        public string EmailAddress   {get; set;}
        public string MobilePhoneNumber {get; set;}
        // New ALI
        public string PlanID {get; set;}
        public string StatusID {get; set;}
        public decimal Premium {get; set;}
        public string RelationshipID {get; set;}
        public string TypeID {get; set;}
        public string Age {get; set;}
        
        public Insured(){
        }       
    }
    
    public class Beneficiary{
        public string Name    {get; set;}
        public date  DOB {get; set;}
        public string PlaceofBirth  {get; set;}
        public string Gender  {get; set;}
        public string RelationwithInsured   {get; set;}
        public string PercentageofBenefit   {get; set;}            
        
        public Beneficiary(){
        }       
    }    

    public class TrxPayment{
        public string TransactionType    {get; set;}
        public date  SubmissionDate  {get; set;}
        public date  PaymentDate     {get; set;}
        public date  DueDate     {get; set;}
        public decimal Amount  {get; set;}
        
        // new ALI
        public string Type    {get; set;}
        public string REFFERENCENO    {get; set;}
        public string ACCOUNTNO    {get; set;}
        public string CARDNO    {get; set;}
        public string ACCOUNTNAME    {get; set;}
        public string CARDNAME    {get; set;}
        public string BANK    {get; set;}
        public string CARDEXPIRE    {get; set;}
        public string Status    {get; set;}

        public string BILLINGNO    {get; set;}
        public date Payment_DATE    {get; set;}
        public string AGE    {get; set;}
        public string MONTHSBILLED    {get; set;}
        public string POLICYNO    {get; set;}
        public string PRODUCT    {get; set;}
        public string AUTHCODE    {get; set;}
        public string REMARK    {get; set;}
        public integer COUNT_PAID    {get; set;}
        public integer COUNT_NOT_PAID    {get; set;}

        public TrxPayment(){
        }       
    }

    public class TrxPolicyHistory{
        // new ALI
        public string UserID    {get; set;}
        public date  EventDate  {get; set;}
        public string EventType     {get; set;}
        public string Description     {get; set;}
        public string PolicyStatus  {get; set;}
        public string Remark  {get; set;}
        
        public TrxPolicyHistory(){
        }       
    }

    public class DetailFund{
        public string FundCode  {get; set;}
        public decimal TotalUnitFund {get; set;}
        public decimal FundPrice {get; set;}
        public decimal FundAllocation  {get; set;}
        public decimal TotFundAmount    {get; set;}
        public date NAVDate  {get; set;}
        
        public DetailFund(){
        }       
    } 
    
    public class FundTransaction{
        public string FundCodes  {get; set;}
        public decimal UnitPrice {get; set;}
        public string  FundCurrency {get; set;}
        public date FundPriceDate  {get; set;}
        public date ValuationDate   {get; set;}
        public string Spread  {get; set;}
        public string TrxCode {get; set;}
        public decimal TrxAmount {get; set;}
        public decimal TrxUnit {get; set;}
        public date TrxDate  {get; set;}
        public date TrxEffectiveDate  {get; set;}
        public string ProcessingType {get; set;}
        public string ProcessingMode {get; set;}
        
        public FundTransaction(){
        }       
    }
    
    public class CashValueDetail{
        public decimal Loan    {get; set;}
        public decimal LoanInterest {get; set;}
        public decimal Dividend {get; set;}
        public decimal DividendInterest {get; set;}
        public decimal FtrPremDeposit  {get; set;}
        public decimal FtrPremDepInter  {get; set;}
        public decimal CashValue {get; set;}
        
        public CashValueDetail(){
        }       
    }
        
    public class TrxClaim{
        public string ProductType    {get; set;}
        public string ClaimNumber    {get; set;}
        public string ClaimType      {get; set;}
        public string ClaimPlan      {get; set;}
        public date  SubmissionDate  {get; set;}
        public date  ApprovalDate    {get; set;}
        public decimal Amount         {get; set;}
        public string ClaimCurrency  {get; set;}
        public string ClaimStatus1   {get; set;}
        public string ClaimStatus2   {get; set;}
        public string StatusDesc   {get; set;}    

        // new ALI
        public string MODIFYDATE   {get; set;}    
        public string CLAIMANT   {get; set;}    
        public string HOSPITAL   {get; set;}    
        public date ADMISSIONDATE   {get; set;}    
        public string REGULARDAYS   {get; set;}    
        public string ICUDAYS   {get; set;}    
        public string ISEXGRATIACASE   {get; set;}    
        public string REMARK   {get; set;}    
        public date DECISIONDATE   {get; set;}    
        public date PAYMENTDATE   {get; set;}    
        public string ACCOUNTNO   {get; set;}    
        public string ACCOUNTNAME   {get; set;}    
        public string BANKNAME   {get; set;}    
        
        public TrxClaim(){
        }       
    }

    public class TrxRHS{
        // new ALI
        public string CaseNumber    {get; set;}
        public string Type    {get; set;}
        public string Subject      {get; set;}
        public date Datetimeopened      {get; set;}
        public string Status  {get; set;}
        public string Owner   {get; set;}
        
        public TrxRHS(){
        }       
    }

    public class TrxCHS{
        // new ALI
        public string CaseNumber    {get; set;}
        public string Type    {get; set;}
        public string Subject      {get; set;}
        public date Datetimeopened      {get; set;}
        public string Status  {get; set;}
        public string Owner   {get; set;}
        
        public TrxCHS(){
        }       
    }

    public class TrxInquiry{
        // new ALI
        public string CaseNumber    {get; set;}
        public string Type    {get; set;}
        public string Subject      {get; set;}
        public date Datetimeopened      {get; set;}
        public string Status  {get; set;}
        public string Owner   {get; set;}
        
        public TrxInquiry(){
        }       
    }

    public class TrxCallNote{
        // new ALI
        public string SOURCE    {get; set;}
        public string NOTE    {get; set;}
        public string STATUS      {get; set;}
        public string CWC  {get; set;}
        public string CREATEBY   {get; set;}
        public date CREATEDATE      {get; set;}
        public string CREATEDATE2      {get; set;}
        public string RETURNCODE   {get; set;}
        
        public TrxCallNote(){
        }       
    }

    public class FPAPolicy{
        // new ALI
        public string APPLICATIONNO    {get; set;}
        public string INSUREDNAME    {get; set;}
        public date DATEOFBIRTH      {get; set;}
        public string StatusPolis  {get; set;}
        public string GENDER   {get; set;}
        public string ADDRESS   {get; set;}
        public string RT_RW   {get; set;}
        public string ZipCode   {get; set;}
        public string City   {get; set;}
        public string Email   {get; set;}
        public date AKTIFDATE   {get; set;}
        public date EXPIREDDATE   {get; set;}
        public string AccountNo   {get; set;}
        public string OfficePhone   {get; set;}
        public string MobilePhone   {get; set;}
        public decimal PREMIUMAMOUNT   {get; set;}
        public string SumAssured   {get; set;}
        
        public FPAPolicy(){
        }       
    }

    public class FPABeneficiary{
        // new ALI
        public string APPLICATIONNO    {get; set;}
        public string BENEFICIARYNAME    {get; set;}
        public date BENEFICIARYDOB      {get; set;}
        public string BENEFICIARYGENDER  {get; set;}
        public string BENEFICIARYRELATION   {get; set;}
        public string BENEFICIARYPERCENTAGE   {get; set;}

        public FPABeneficiary(){
        }       
    }
    
    public class GIClaim{
        public string PolicyNo    {get; set;}
        public string ClaimRegNo {get; set;}
        public string ClaimStatus {get; set;}
        public string Branch {get; set;}
        public string ClientName {get; set;}
        public date NotifDate {get; set;}
        public date RegDate {get; set;}
        public date DateofLoss {get; set;}
        public string Description {get; set;}
        public string AccidentPlace {get; set;}
        public string RepairShop {get; set;}
        public date ApprPayDate {get; set;}
        public date PaymentDate {get; set;}
        public string DriverName {get; set;}
        
        public GIClaim(){
        }       
    }
    public class GIEndorsement{
        public string PolicyNo    {get; set;}
        public string CertificateNo {get; set;}
        public string ContractType {get; set;}
        public date InforceDate {get; set;}
        public date StartDate {get; set;}
        public date EndDate {get; set;}
        public string EndorsementRemark {get; set;}
        public string Status {get; set;}
        public string TypeGI {get; set;}
        
        public GIEndorsement(){
        }       
    }
    public class PremiumBreakdown{
        public string PlanCode    {get; set;}
        public decimal BasicPlan {get; set;}
        public decimal ModalPlanPremium {get; set;}
        public decimal ModalPlanLoading {get; set;}
        public string PlanType    {get; set;}
        public date EffectiveDate {get; set;}
        public date TerminationDate {get; set;}
        public decimal PlanSi    {get; set;}
        public string ClassCode {get; set;}
        public date ExpiredDate {get; set;}
        public string PlanStatus {get; set;}
        
        public PremiumBreakdown(){
        }       
    }
    
    public class PolicyChange{ 
        public string TransactionCode   {get; set;}
        public string TransactionDesc  {get; set;}
        public date SubmitDate {get; set;}
        public date CreateDate {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}

        // new ALI
        public string EventType {get; set;}
        public string UserID {get; set;}
        public string Source {get; set;}
        
        public PolicyChange(){
        }       
    }
    
    public class TableofContent{
        public string tableList1    {get; set;}
        public string tableList2    {get; set;}
        public string tableList3    {get; set;}
        public string tableList4    {get; set;}
        public string tableList5    {get; set;}
        public string tableList6    {get; set;}
        public string tableList7    {get; set;}
        public string tableList8    {get; set;}
        public string tableList9    {get; set;}
        public string tableList10    {get; set;}
        public string tableList11   {get; set;}
        public string tableList12    {get; set;}
        public string tableList13    {get; set;}
        public string tableList14    {get; set;}
        public string tableList15    {get; set;}
        public string tableLabel1    {get; set;}
        public string tableLabel2    {get; set;}
        public string tableLabel3    {get; set;}
        public string tableLabel4    {get; set;}
        public string tableLabel5    {get; set;}
        public string tableLabel6    {get; set;}
        public string tableLabel7    {get; set;}
        public string tableLabel8    {get; set;}
        public string tableLabel9    {get; set;}
        public string tableLabel10    {get; set;}
        public string tableLabel11    {get; set;}
        public string tableLabel12    {get; set;}
        public string tableLabel13    {get; set;}
        public string tableLabel14    {get; set;}
        public string tableLabel15    {get; set;}
        public string tableValue1    {get; set;}
        public string tableValue2    {get; set;}
        public string tableValue3    {get; set;}
        public string tableValue4    {get; set;}
        public string tableValue5    {get; set;}
        public string tableValue6    {get; set;}
        public string tableValue7    {get; set;}
        public string tableValue8    {get; set;}
        public string tableValue9    {get; set;}
        public string tableValue10    {get; set;}
        public string tableValue11    {get; set;}
        public string tableValue12    {get; set;}
        public string tableValue13    {get; set;}
        public string tableValue14    {get; set;}
        public string tableValue15    {get; set;}
        
        public TableofContent(){
        }       
    }
    
    public class AccountDetail{
        public string AcchBranch {get; set;}
        public string AccountNo {get; set;}
        public date AccountEff {get; set;}
        public date AccountExp {get; set;}
        public string AccountType {get; set;}
        public string AccountStatus {get; set;}
        public string AccountName {get; set;}
        public string CollectionBank {get; set;}
        public string RejectCode {get; set;}
        public date RejectDate {get; set;}
        
        public AccountDetail(){
        }       
    }
    
    public class PremiumDetail{
        public string PremiumType {get; set;}
        public string PremRef {get; set;}
        public string PMRMKC {get; set;}
        public string PMRMKD {get; set;}
        public string PMRMKD2 {get; set;}
        public string PMRMKD3 {get; set;}
        public string PMDEPT {get; set;}
        public string PMUSER {get; set;}
        public string PMLUPD {get; set;}
        public string PMCOMD {get; set;}
        public string PMCOMS {get; set;}
        
        public PremiumDetail(){
        }       
    }
    
    public class InterestInfo{
        public string AddCoverCode  {get; set;}
        public string AddCoverName {get; set;}
        public string AddCoverType {get; set;}
        public decimal AddCoverPremium {get; set;}
        public decimal SIofAddCover   {get; set;}
        
        public InterestInfo(){
        }       
    }
        
    public PolicyDetailControllerALI(ApexPages.StandardController controller) {

        //string contactId = controller.getID();  //remarked by WK, 20150422
        ambilRLS = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsRLS();
        ambilNonRLSALI = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsNonRLSALI();
        ambilGI = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsGI();
        pelanggan = new Customer();    
        agen = new Agent();
        polisRider = new PolicyRider(); 
        detailFund = new DetailFund();
        insuredList = new List<Insured>(); 
        beneficiaryList = new List<Beneficiary>();
        trxPaymentList = new List<TrxPayment>();
        trxClaimList = new List<TrxClaim>();
        trxOpenLastClaimList = new List<TrxClaim>();
        // new ALI
        trxRHSList = new List<TrxRHS>();
        trxOpenLastRHSList = new List<TrxRHS>();
        trxBackEndRHSList = new List<TrxCallNote>();
        trxBEP = new List<BackEndPaging__c>();

        trxCHSList = new List<TrxCHS>();
        trxOpenLastCHSList = new List<TrxCHS>();
        trxBackEndCHSList = new List<TrxCallNote>();

        trxInquiryList = new List<TrxInquiry>();
        trxOpenLastInquiryList = new List<TrxInquiry>();
        trxBackEndInquiryList = new List<TrxCallNote>();
        
        FPAPolicyList = new List<FPAPolicy>();
        FPABeneficiaryList = new List<FPABeneficiary>();
        
        trxPayInfoList = new List<TrxPayment>();
        TrxPolicyHistoryList = new List<TrxPolicyHistory>();

        trxPaymentList5 = new List<TrxPayment>();
        trxClaimList5 = new List<TrxClaim>();
        trxBackEndRHSList5 = new List<TrxCallNote>();
        TrxPolicyHistoryList5 = new List<TrxPolicyHistory>();

        detailFundList = new List<DetailFund>();
        fundTrxList = new List<FundTransaction>();
        cashValueList = new List<CashValueDetail>();
        giClaimList = new List<GIClaim>();
        giEndorsementList = new List<GIEndorsement>();
        premiumBreakdownList = new List<PremiumBreakdown>();
        policyChangeList = new List<PolicyChange>();
        TOCList = new List<TableofContent>();
        accountDetailList = new List<AccountDetail>();
        premiumDetailList = new List<PremiumDetail>();
        interestInfoList = new List<InterestInfo>();
        contactId = controller.getID();
        //contactId = '0039000001XAPJe'; //Test static ID
    } 
    
    
    //public PolicyDetailController(string id){
    public PolicyDetailControllerALI(){
        ambilRLS = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsRLS();
        ambilNonRLSALI = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsNonRLSALI();
        ambilGI = new CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsGI();
        pelanggan = new Customer();    
        agen = new Agent();
        polisRider = new PolicyRider(); 
        detailFund = new DetailFund();
        insuredList = new List<Insured>(); 
        beneficiaryList = new List<Beneficiary>();
        trxPaymentList = new List<TrxPayment>();
        trxClaimList = new List<TrxClaim>();

        // new ALI
        trxRHSList = new List<TrxRHS>();
        trxOpenLastRHSList = new List<TrxRHS>();
        trxBackEndRHSList = new List<TrxCallNote>();
        trxBEP = new List<BackEndPaging__c>();

        trxCHSList = new List<TrxCHS>();
        trxOpenLastCHSList = new List<TrxCHS>();
        trxBackEndCHSList = new List<TrxCallNote>();

        trxInquiryList = new List<TrxInquiry>();
        trxOpenLastInquiryList = new List<TrxInquiry>();
        trxBackEndInquiryList = new List<TrxCallNote>();

        FPAPolicyList = new List<FPAPolicy>();
        FPABeneficiaryList = new List<FPABeneficiary>();

        trxPayInfoList = new List<TrxPayment>();
        TrxPolicyHistoryList = new List<TrxPolicyHistory>();

        trxPaymentList5 = new List<TrxPayment>();
        trxClaimList5 = new List<TrxClaim>();
        trxBackEndRHSList5 = new List<TrxCallNote>();
        TrxPolicyHistoryList5 = new List<TrxPolicyHistory>();

        detailFundList = new List<DetailFund>();
        fundTrxList = new List<FundTransaction>();
        cashValueList = new List<CashValueDetail>();
        giClaimList = new List<GIClaim>();
        giEndorsementList = new List<GIEndorsement>();
        premiumBreakdownList = new List<PremiumBreakdown>();
        policyChangeList = new List<PolicyChange>();
        TOCList = new List<TableofContent>();
        accountDetailList = new List<AccountDetail>();
        premiumDetailList = new List<PremiumDetail>();
        interestInfoList = new List<InterestInfo>();
        //contactId = id;
    }
    
    public void callDataviaWS(){   //move all lines to this method, by WK, 20150422 --> to fix exception :DML not allowed 
        List<AppLog__c> logList = new List<AppLog__c>();        
        AppLog__c applogWs = new AppLog__c();
        AppLog__c applogScreen = new AppLog__c();
        applogScreen.id__c = contactId;
        applogScreen.method__c = 'load police detatil screen ';
        //applogScreen.start_date__c = system.now();
        applogScreen.StartLongTime__c = system.now().getTime();
    
        //List<Contact> contactList = [SELECT Id, Policy_No_ALI__c, Entity__c, PolicyApp__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
        List<Contact> contactList = [SELECT Id, Policy_No_ALI__c, Entity__c, PolicyApp__c, Phone, MobilePhone, HomePhone, Policy_Status__c, Policy_Effective_Date__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Premium__c, Segment_Name__c, Branch_Name__c, Branch_Code__c, Date_of_Accident__c, Driver__c, Accident_Place__c, Detail_of_Damage__c, Production_Year__c, Licence_Number__c, Machine_No__c, Chassis_no__c, Vehicle_Type__c, Color__c, Machine_Capacity__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
        Contact contactRec = null;
        /*
        pelanggan = new Customer();    
        agen = new Agent();
        polisRider = new PolicyRider(); 
        detailFund = new DetailFund();
        insuredList = new List<Insured>(); 
        beneficiaryList = new List<Beneficiary>();
        trxPaymentList = new List<TrxPayment>();
        trxClaimList = new List<TrxClaim>();
        detailFundList = new List<DetailFund>();
        fundTrxList = new List<FundTransaction>();
        cashValueList = new List<CashValueDetail>();
        giClaimList = new List<GIClaim>();
        giEndorsementList = new List<GIEndorsement>();
        premiumBreakdownList = new List<PremiumBreakdown>();
        policyChangeList = new List<PolicyChange>();
        TOCList = new List<TableofContent>();
        accountDetailList = new List<AccountDetail>();
        premiumDetailList = new List<PremiumDetail>();
        interestInfoList = new List<InterestInfo>();
        */
        isDisplayed = true;
        displayRLSOnly = true;
        AdditionalNonRLS = false;
        displayGIOnly = false;
        //String errorDSRTN = '';
                                           
        //Call Webservice
        if(contactList.size()>0){
            contactRec = contactList[0];
            policyNo = contactRec.Policy_No_ALI__c;
            entity = contactRec.Entity__c;
            policyApp = contactRec.PolicyApp__c;
            
            //CCCWebserviceConnectors.ArrayOfGetPolicyDetailsClipper ambil = srv.GetPolicyDetailsSFDC(contactRec.Policy_No_ALI__c, contactRec.PolicyApp__c, contactRec.Entity__c, '');
            applogWs.id__c = contactId;
            //applogWs.method__c = 'call webservice : CCCWebserviceConnectors10Ali.iServiceSoap()';
            //applogWs.start_date__c = system.now();
            applogWS.StartLongTime__c = system.now().getTime();
            CCCWebserviceConnectors10Ali.iServiceSoap srv = new CCCWebserviceConnectors10Ali.iServiceSoap();
            CreateToken ct = new CreateToken();
            token = ct.getToken();
            system.debug('##Token '+token);
            if(contactRec.PolicyApp__c.toUpperCase() == 'BIS'){
                polisRider.MataUang = 'Rp';
                tipe = 'Non RLS 1'; 
            }
            else if(contactRec.PolicyApp__c.toUpperCase() == 'DMTM' || contactRec.PolicyApp__c.toUpperCase() == 'FREEPA'){
                polisRider.MataUang = 'Rp';
                tipe = 'Non RLS 2'; 
            }
            else if(contactRec.PolicyApp__c.toUpperCase() == 'CLIPPER'){
                tipe = 'Non RLS 3'; 
            }
            else if(contactRec.PolicyApp__c.toUpperCase() == 'RLS'){
                tipe = 'RLS';
            }
            else if(contactRec.PolicyApp__c.toUpperCase() == 'PSEA' || contactRec.PolicyApp__c.toUpperCase() == 'CARE'){
                tipe = 'GI';
            }
            else{
                tipe = '';
            }
            
            //PolicyApp = RLS
            if(tipe == 'RLS'){
                if(!Test.isRunningTest()){ ambilRLS = srv.GetPolicyDetailsLifeRLS(contactRec.Policy_No_ALI__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken()); }
                //CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsRLS ambil = srv.GetPolicyDetailsLifeRLS(contactRec.Policy_No_ALI__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                system.debug('Ambil CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsRLS: ' +ambilRLS);
                
                //applogWs.end_date__c = system.now();
                applogWs.EndLongTime__c = system.now().getTime();
                applogWs.method__c = 'call webservice : CCCWebserviceConnectors10Ali.GetPolicyDetailsLifeRLS()';
                //insert applog;
            
                try{
                    if(ambilRLS != null){
                        system.debug('start RLS here...');
                        
                        panjang = ambilRLS.PolicyDetailsRLS.size();
                        
                        if(panjang > 0){
                            String temp1 = '';
                            String temp2 = '';
                            String temp3 = '';
                            String temp4 = '';
                            String temp5 = '';
                            String temp6 = '';
                            String temp7 = '';
                            String temp8 = '';
                            String temp9 = '';
                            String temp10 = '';
                            String tempRHS = '';
                            Integer countRHS = 0;
                                
                            for(integer i=0;i<panjang;i++){
                                errorDSRTN = bacaString(ambilRLS.PolicyDetailsRLS[i].DESRTN);
                                system.debug('errorDSRTN: ' +errorDSRTN);
                                
                                if(errorDSRTN != null && errorDSRTN != '' && (!errorDSRTN.contains('Sukses')) && (!errorDSRTN.contains('SUKSES'))){
                                    ApexPages.Message errEmail = new ApexPages.Message(ApexPages.Severity.ERROR,'There is error on web service. Please contact administrator.'); 
                                    ApexPages.addMessage(errEmail);
                                    isDisplayed = false;
                                    displayGIOnly = false;
                                    break;
                                }    
                                if(i==0){
                                    pelanggan.CustomerID = bacaString(ambilRLS.PolicyDetailsRLS[i].POWNID);
                                    if(pelanggan.CustomerID == '0'){
                                        pelanggan.CustomerID = '';
                                    }
                                    pelanggan.Name = bacaString(ambilRLS.PolicyDetailsRLS[i].POWNER);
                                    pelanggan.PlaceofBirth = bacaString(ambilRLS.PolicyDetailsRLS[i].LPAYPB);
                                    if(pelanggan.PlaceofBirth == '0'){
                                        pelanggan.PlaceofBirth = '';
                                    }
                                    try{
                                        decimal lpaydb = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].LPAYDB);
                                        //if(bacaDecimal(ambilRLS.PolicyDetailsRLS[i].LPAYDB) != null && bacaDecimal(ambilRLS.PolicyDetailsRLS[i].LPAYDB) != 0)
                                        if(lpaydb != null && lpaydb != 0){
                                            //pelanggan.DOB = convertStringToDate(String.valueOf(bacaDecimal(ambilRLS.PolicyDetailsRLS[i].LPAYDB)));
                                            pelanggan.DOB = convertStringToDate(String.valueOf(lpaydb));
                                         }
                                        else{
                                            pelanggan.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in DOB: '+e.getMessage());
                                    }
                                    pelanggan.Gender = bacaString(ambilRLS.PolicyDetailsRLS[i].POWSEX);
                                    pelanggan.Alamat1 = bacaString(ambilRLS.PolicyDetailsRLS[i].PADR1);
                                    pelanggan.Alamat2 = bacaString(ambilRLS.PolicyDetailsRLS[i].PADR2);
                                    pelanggan.Alamat3 = bacaString(ambilRLS.PolicyDetailsRLS[i].PADR3);
                                    pelanggan.Alamat4 = bacaString(ambilRLS.PolicyDetailsRLS[i].PADR4);
                                    pelanggan.EmailAddress = bacaString(ambilRLS.PolicyDetailsRLS[i].PEMAL);
                                    pelanggan.AgentServicing = bacaString(ambilRLS.PolicyDetailsRLS[i].PAGT1);
                                    pelanggan.AgentProducer = bacaString(ambilRLS.PolicyDetailsRLS[i].PPAGT1);
                                    
                                    //Policy Detail
                                    polisRider.PolicyNumber = bacaString(ambilRLS.PolicyDetailsRLS[i].PNO);
                                    polisRider.MataUang = bacaString(ambilRLS.PolicyDetailsRLS[i].REFNO).subString(0,3);
                                    polisRider.ReferenceNumber = bacaString(ambilRLS.PolicyDetailsRLS[i].REFNO).subString(3,12);
                                    polisRider.ProductCode = bacaString(ambilRLS.PolicyDetailsRLS[i].PLAN);
                                    polisRider.ProductName = bacaString(ambilRLS.PolicyDetailsRLS[i].PLAND);
                                    polisRider.PolicyStatus = bacaString(ambilRLS.PolicyDetailsRLS[i].PSTU);
                                    polisRider.USPRRLTN = bacaString(ambilRLS.PolicyDetailsRLS[i].USPRRLTN);
                                    string bsi = bacaString(ambilRLS.PolicyDetailsRLS[i].BSI);
                                    if(bsi != null && bsi.trim() != ''){ polisRider.BasicSI = decimal.valueOf(double.valueOf(bsi)); }
                                    else{
                                        polisRider.BasicSI = 0;
                                    }
                                    string ltbprm = bacaString(ambilRLS.PolicyDetailsRLS[i].LTBPRM);
                                    if(ltbprm != null && ltbprm.trim() != ''){ polisRider.TotalPremium = decimal.valueOf(double.valueOf(ltbprm)); }
                                    else{
                                        polisRider.TotalPremium = 0;
                                    }
                                    string ltsi = bacaString(ambilRLS.PolicyDetailsRLS[i].LTSI);
                                    if(ltsi != null && ltsi.trim() != ''){ polisRider.TotalSumInsured = decimal.valueOf(double.valueOf(ltsi)); }
                                    else{
                                        polisRider.TotalSumInsured = 0;
                                    }
                                    string ltrmp = bacaString(ambilRLS.PolicyDetailsRLS[i].LTRMP);
                                    if(ltrmp != null && ltrmp.trim() != ''){ polisRider.RegularTopUp = decimal.valueOf(double.valueOf(ltrmp)); }
                                    else{
                                        polisRider.RegularTopUp = 0;
                                    }
                                    string lilsp = bacaString(ambilRLS.PolicyDetailsRLS[i].LILSP);
                                    if(lilsp != null && lilsp.trim() != ''){ polisRider.LumpSumTopUp = decimal.valueOf(double.valueOf(lilsp)); }
                                    else{
                                        polisRider.LumpSumTopUp = 0;
                                    }
                                    string brprem = bacaString(ambilRLS.PolicyDetailsRLS[i].BRPREM);
                                    if(brprem != null && brprem.trim() != ''){ polisRider.BasicRegPrem = decimal.valueOf(brprem); }
                                    else{
                                        polisRider.BasicRegPrem = 0;
                                    }
                                    polisRider.PaymentMethod = bacaString(ambilRLS.PolicyDetailsRLS[i].PMTHOD);
                                    polisRider.PaymentMode = bacaString(ambilRLS.PolicyDetailsRLS[i].PMODE);
                                    polisRider.Description = bacaString(ambilRLS.PolicyDetailsRLS[i].STATUSDESC);
                                    try{
                                        double usdapp = bacaDouble(ambilRLS.PolicyDetailsRLS[i].USDAPP);
                                        if(usdapp != null && usdapp != 0){ polisRider.DateofApplication = convertStringToDate(String.valueOf(usdapp.round())); }
                                        else{
                                            polisRider.DateofApplication = null;
                                        }
                                        double pdoi = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PDOI); 
                                        if(pdoi != null && pdoi != 0){ polisRider.IssuedDate  = convertStringToDate(String.valueOf(pdoi.round())); }
                                        else{
                                            polisRider.IssuedDate = null;
                                        }
                                        double peff = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PEFF);
                                        if(peff != null && peff != 0){ polisRider.EffectiveDate  = convertStringToDate(String.valueOf(peff.round())); }
                                        else{
                                            polisRider.EffectiveDate = null;
                                        }
                                        double pexp = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PEXP);
                                        if(pexp != null && pexp != 0){ polisRider.ExpiredDate = convertStringToDate(String.valueOf(pexp.round())); }
                                        else{
                                            polisRider.ExpiredDate = null;
                                        }
                                        double pterm = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PTERM);
                                        if(pterm != null && pterm != 0){ polisRider.TerminationDate = convertStringToDate(String.valueOf(pterm.round())); }
                                        else{
                                            polisRider.TerminationDate = null;
                                        }
                                        double pdue = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PDUE);
                                        if(pdue != null && pdue != 0){ polisRider.DueDate1 = convertStringToDate(String.valueOf(pdue.round())); }
                                        else{
                                            polisRider.DueDate1 = null;
                                        }
                                        double lphofd = bacaDouble(ambilRLS.PolicyDetailsRLS[i].LPHOFD);
                                        if(lphofd != null && lphofd != 0){ polisRider.PremiumHolidayStart = convertStringToDate(String.valueOf(lphofd.round())); }
                                        else{
                                            polisRider.PremiumHolidayStart = null;
                                        }
                                        double lphotd = bacaDouble(ambilRLS.PolicyDetailsRLS[i].LPHOTD);
                                        if(lphotd != null && lphotd != 0){ polisRider.PremiumHolidayEnd = convertStringToDate(String.valueOf(lphotd.round())); }
                                        else{
                                            polisRider.PremiumHolidayEnd = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in date format (Policy Detail section): '+e.getMessage());
                                    }
                                    integer testint = bacaInteger(1);
                                    val9 = '';
                                    
                                    //Agent Info
                                    agen.AgentNo =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGC);
                                    agen.Entity =  bacaString(ambilRLS.PolicyDetailsRLS[i].ENTITY);        
                                    if(agen.Entity == 'IF'){
                                        agen.Entity = 'AFI';
                                    }
                                    if(agen.Entity == 'IB'){
                                        agen.Entity = 'AMFS';
                                    }
                                    agen.DistributionCode =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGDSCD);
                                    agen.DistributionType =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGDSTY);
                                    
                                    agen.AgentName =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGNAME);
                                    agen.AgentID =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGID);
                                    agen.Status =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGSTU);
                                    agen.Area =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGAREA);
                                    agen.HomeAddress1 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGADR1);
                                    agen.HomeAddress2 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGADR2);
                                    agen.HomeAddress3 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGADR3);
                                    agen.HomeAddress4 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGADR4);
                                    agen.OfficeAddress1 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGOFF1);
                                    agen.OfficeAddress2 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGOFF2);
                                    agen.OfficeAddress3 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGOFF3);
                                    agen.OfficeAddress4 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGOFF4);
                                    agen.EmailAddress =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGEMIL);
                                    agen.HomePhone1 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGTEL1);
                                    if(agen.HomePhone1 == '0'){
                                        agen.HomePhone1 = '';
                                    }
                                    agen.HomePhone2 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGTEL2);
                                    if(agen.HomePhone2 == '0'){
                                        agen.HomePhone2 = '';
                                    }
                                    agen.OfficePhone =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGOFFP);
                                    if(agen.OfficePhone == '0'){
                                        agen.OfficePhone = '';
                                    }
                                    agen.MobilePhone1 =  bacaString(ambilRLS.PolicyDetailsRLS[i].AGMOB);
                                    if(agen.MobilePhone1 == '0'){
                                        agen.MobilePhone1 = '';
                                    }
                                    try{
                                        double agjoindt = bacaDouble(ambilRLS.PolicyDetailsRLS[i].AGJOINDT);
                                        if(agjoindt != null && agjoindt != 0){
                                            agen.JoinDate = convertStringToDate(String.valueOf(agjoindt.round()));
                                        }
                                        else{
                                            agen.JoinDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured join date (Agent Info section): '+e.getMessage());
                                    }
                                }   
                                                            
                                //Insured
                                string pname = bacaString(ambilRLS.PolicyDetailsRLS[i].PNAME);
                                string ppob = bacaString(ambilRLS.PolicyDetailsRLS[i].PPOB);
                                string psex = bacaString(ambilRLS.PolicyDetailsRLS[i].PSEX);
                                string pid = bacaString(ambilRLS.PolicyDetailsRLS[i].PID);
                                string piemal = bacaString(ambilRLS.PolicyDetailsRLS[i].PIEMAL);
                                string plmbno = bacaString(ambilRLS.PolicyDetailsRLS[i].PLMBNO);
                                decimal pdob = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].PDOB);
                                
                                val1 = pname.trim()+'::'+ppob.trim()+'::'+String.valueOf(pdob).trim()+'::'+psex.trim()+'::'+pid.trim()+'::'+piemal.trim()+'::'+plmbno.trim();
                                system.debug('Val1: ' +val1);
                                
                                if(temp1 != val1){
                                    Insured tertanggung = new Insured(); 
                                    tertanggung.Name = pname;
                                    tertanggung.PlaceofBirth = ppob;
                                    if(tertanggung.PlaceofBirth == '0'){
                                        tertanggung.PlaceofBirth = '';
                                    }
                                    try{
                                        tertanggung.DOB = null;
                                        if(pdob != null && pdob != 0){
                                            tertanggung.DOB = convertStringToDate(String.valueOf(pdob));
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in insured DOB: '+e.getMessage());
                                    }
                                    
                                    tertanggung.Gender = psex;
                                    tertanggung.IdentificationNo = pid;
                                    if(tertanggung.IdentificationNo == '0'){ tertanggung.IdentificationNo = ''; }
                                    tertanggung.EmailAddress = piemal;
                                    if(tertanggung.EmailAddress == '0'){ tertanggung.EmailAddress = ''; }
                                    tertanggung.MobilePhoneNumber = plmbno;
                                    if(tertanggung.MobilePhoneNumber == '0'){ tertanggung.MobilePhoneNumber = ''; }
                                    insuredList.add(tertanggung);
                                    temp1 = val1;
                                }
                                            
                                //Payment history
                                string wpmd = bacaString(ambilRLS.PolicyDetailsRLS[i].WPMD);
                                decimal wpdos = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].WPDOS);
                                decimal wpdot = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].WPDOT);
                                decimal wpdod = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].WPDOD);
                                decimal wpprm = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].WPPRM);
                                
                                val2 = wpmd.trim() +'::'+string.valueOf(wpdos).trim() +'::'+String.valueOf(wpdot).trim()+'::'+String.valueOf(wpdod).trim()+'::'+String.valueOf(wpprm).trim();
                                system.debug('Val2 = ' +val2);
                                
                                if(temp2 != val2){
                                    TrxPayment payment = new TrxPayment();
                                    payment.TransactionType = wpmd;
                                    if(payment.TransactionType == '0'){ payment.TransactionType = ''; }
                                    try{
                                        payment.SubmissionDate = null;
                                        if(wpdos != null && wpdos != 0){
                                            payment.SubmissionDate = convertStringToDate(String.valueOf(wpdos));
                                        }
                                        payment.PaymentDate = null;
                                        if(wpdot != null && wpdot != 0){
                                            payment.PaymentDate = convertStringToDate(String.valueOf(wpdot));
                                        }
                                            payment.DueDate = null;
                                        if(wpdod != null && wpdod != 0){
                                            payment.DueDate = convertStringToDate(String.valueOf(wpdod));
                                        }

                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    if(wpprm != null && wpprm != 0){
                                        payment.Amount = wpprm;
                                    }
                                    else{
                                        payment.Amount = 0;
                                    }
                                    trxPaymentList.add(payment);
                                    temp2 = val2;
                                } 
                                
                                //Claim history
                                string xlprod = bacaString(ambilRLS.PolicyDetailsRLS[i].XLPROD);
                                string xltype = bacaString(ambilRLS.PolicyDetailsRLS[i].XLTYPE);
                                string xlplan = bacaString(ambilRLS.PolicyDetailsRLS[i].XLPLAN);
                                string xlcurr = bacaString(ambilRLS.PolicyDetailsRLS[i].XLCURR);
                                string xlsts = bacaString(ambilRLS.PolicyDetailsRLS[i].XLSTS);
                                string xstsdes = bacaString(ambilRLS.PolicyDetailsRLS[i].XSTSDES);
                                decimal xlnumb = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].XLNUMB);
                                decimal xldtsub = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].XLDTSUB);
                                decimal xldtapp = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].XLDTAPP);
                                decimal xlamount = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].XLAMOUNT);
                                
                                val3 = xlprod.trim() +'::'+String.valueOf(xlnumb).trim() +'::'+xltype.trim() +'::'+xlplan.trim()+'::'+String.valueOf(xldtsub).trim()+'::'
                                       +String.valueOf(xldtapp).trim()+'::'+String.valueOf(xlamount).trim()+'::'+xlcurr.trim() +'::'+xlsts.trim() +'::'+xstsdes.trim();
                                
                                system.debug('Val3: ' +val3);
                                
                                if(temp3 != val3){
                                    TrxClaim claim = new TrxClaim();
                                    claim.ProductType = xlprod;
                                    claim.ClaimNumber = String.valueOf(xlnumb);
                                    if(claim.ClaimNumber == '0'){
                                        claim.ClaimNumber = '';
                                    }
                                    claim.ClaimType  = xltype;
                                    claim.ClaimPlan  = xlplan;
                                    try{
                                        if(xldtsub != null && xldtsub != 0){
                                            claim.SubmissionDate = convertStringToDate(String.valueOf(xldtsub));
                                        }
                                        else{
                                            claim.SubmissionDate = null;
                                        }
                                        if(xldtapp != null && xldtapp != 0){
                                            claim.ApprovalDate = convertStringToDate(String.valueOf(xldtapp));
                                        }
                                        else{
                                            claim.ApprovalDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    if(xlamount != null && xlamount != 0){
                                        claim.Amount = xlamount;
                                    }
                                    else{
                                        claim.Amount = 0;
                                    } 
                                    claim.ClaimCurrency = xlcurr;
                                    claim.ClaimStatus1 = xlsts;
                                    if(claim.ClaimStatus1 == '0'){
                                        claim.ClaimStatus1 = '';
                                    }
                                    claim.ClaimStatus2 = xstsdes;
                                    if(claim.ClaimStatus2 == '0'){
                                        claim.ClaimStatus2 = '';
                                    }
                                    trxClaimList.add(claim);    
                                    temp3 = val3;
                                }           
                                
                                //Beneficiary
                                string bname = bacaString(ambilRLS.PolicyDetailsRLS[i].BNAME);
                                string bplcdob = bacaString(ambilRLS.PolicyDetailsRLS[i].BPLCDOB);
                                string bgender = bacaString(ambilRLS.PolicyDetailsRLS[i].BGENDER);
                                string brel = bacaString(ambilRLS.PolicyDetailsRLS[i].BREL);
                                string bpercent = bacaString(ambilRLS.PolicyDetailsRLS[i].BPERCENT);
                                decimal bendob = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].BENDOB);
                                
                                val4 = bname.trim()+'::'+bplcdob.trim()+'::'+bgender.trim()+'::'+brel.trim()+'::'+bpercent.trim()+'::'+string.valueOf(bendob).trim();
                                system.debug('Val4: ' +val4);
                                
                                if(temp4 != val4){
                                    Beneficiary benefit = new Beneficiary();
                                    benefit.Name = bname;
                                    try{
                                        if(bendob != null && bendob != 0){
                                            benefit.DOB = convertStringToDate(String.valueOf(bendob));
                                        }
                                        else{
                                            benefit.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in Beneficiary DOB: '+e.getMessage());
                                    }
                                    benefit.PlaceofBirth = bplcdob;
                                    if(benefit.PlaceofBirth == '0'){
                                        benefit.PlaceofBirth = '';
                                    }
                                    benefit.Gender = bgender;
                                    benefit.RelationwithInsured = brel;
                                    benefit.PercentageofBenefit = bpercent;
                                    if (benefit.name != '0' && benefit.name != '') beneficiaryList.add(benefit);
                                    temp4 = val4;
                                }
                                 //Fund Detail
                                string xfcod1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD1);
                                string xfunt1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT1);
                                string xfprc1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC1);
                                string xfalc1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC1);
                                
                                val5 = xfcod1.trim() +'::'+xfunt1.trim()+'::'+xfprc1.trim()+'::'+xfalc1.trim();
                                system.debug('Val5: ' +val5);
                                
                                if(temp5 != val5){
                                    DetailFund detail1 = new DetailFund();
                                    detail1.FundCode = xfcod1;
                                    if(xfunt1 != null && xfunt1.trim() != ''){
                                        detail1.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt1));
                                    }
                                    else{
                                        detail1.TotalUnitFund = 0;
                                    }
                                    if(xfprc1 != null && xfprc1.trim() != ''){
                                        detail1.FundPrice = decimal.valueOf(double.valueOf(xfprc1));
                                    }
                                    else{
                                        detail1.FundPrice = 0;
                                    }
                                    if(xfalc1 != null && xfalc1.trim() != ''){
                                        detail1.FundAllocation = decimal.valueOf(double.valueOf(xfalc1));
                                    }
                                    else{
                                        detail1.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail1);
                                    DetailFund detail2 = new DetailFund();
                                    detail2.FundCode = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD2);
                                    string xfunt2 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT2);
                                    if(xfunt2 != null && xfunt2.trim() != ''){
                                        detail2.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt2));
                                    }
                                    else{
                                        detail2.TotalUnitFund = 0;
                                    }
                                    string xfprc2 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC2);
                                    if(xfprc2 != null && xfprc2.trim() != ''){
                                        detail2.FundPrice = decimal.valueOf(double.valueOf(xfprc2));
                                    }
                                    else{
                                        detail2.FundPrice = 0;
                                    }
                                    string xfalc2 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC2);
                                    if(xfalc2 != null && xfalc2.trim() != ''){
                                        detail2.FundAllocation = decimal.valueOf(double.valueOf(xfalc2));
                                    }
                                    else{
                                        detail2.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail2);
                                    DetailFund detail3 = new DetailFund();
                                    detail3.FundCode = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD3);
                                    string xfunt3 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT3);
                                    if(xfunt3 != null && xfunt3.trim() != ''){
                                        detail3.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt3));
                                    }
                                    else{
                                        detail3.TotalUnitFund = 0;
                                    }
                                    string xfprc3 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC3);
                                    if(xfprc3 != null && xfprc3.trim() != ''){
                                        detail3.FundPrice = decimal.valueOf(double.valueOf(xfprc3));
                                    }
                                    else{
                                        detail3.FundPrice = 0;
                                    }
                                    string xfalc3 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC3);
                                    if(xfalc3 != null && xfalc3.trim() != ''){
                                        detail3.FundAllocation = decimal.valueOf(double.valueOf(xfalc3));
                                    }
                                    else{
                                        detail3.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail3);
                                    DetailFund detail4 = new DetailFund();
                                    detail4.FundCode = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD4);
                                    string xfunt4 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT4);
                                    if(xfunt4 != null && xfunt4.trim() != ''){
                                        detail4.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt4));
                                    }
                                    else{
                                        detail4.TotalUnitFund = 0;
                                    }
                                    string xfprc4 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC4);
                                    if(xfprc4 != null && xfprc4.trim() != ''){
                                        detail4.FundPrice = decimal.valueOf(double.valueOf(xfprc4));
                                    }
                                    else{
                                        detail4.FundPrice = 0;
                                    }
                                    string xfalc4 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC4);
                                    if(xfalc4 != null && xfalc4.trim() != ''){
                                        detail4.FundAllocation = decimal.valueOf(double.valueOf(xfalc4));
                                    }
                                    else{
                                        detail4.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail4);
                                    DetailFund detail5 = new DetailFund();
                                    detail5.FundCode = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD5);
                                    string xfunt5 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT5);
                                    if(xfunt5 != null && xfunt5.trim() != ''){
                                        detail5.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt5));
                                    }
                                    else{
                                        detail5.TotalUnitFund = 0;
                                    }
                                    string xfprc5 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC5);
                                    if(xfprc5 != null && xfprc5.trim() != ''){
                                        detail5.FundPrice = decimal.valueOf(double.valueOf(xfprc5));
                                    }
                                    else{
                                        detail5.FundPrice = 0;
                                    }
                                    string xfalc5 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC5);
                                    if(xfalc5 != null && xfalc5.trim() != ''){
                                        detail5.FundAllocation = decimal.valueOf(double.valueOf(xfalc5));
                                    }
                                    else{
                                        detail5.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail5);
                                    DetailFund detail6 = new DetailFund();
                                    detail6.FundCode = bacaString(ambilRLS.PolicyDetailsRLS[i].XFCOD6);
                                    string xfunt6 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFUNT6);
                                    if(xfunt6 != null && xfunt6.trim() != ''){
                                        detail6.TotalUnitFund = decimal.valueOf(double.valueOf(xfunt6));
                                    }
                                    else{
                                        detail6.TotalUnitFund = 0;
                                    }
                                    string xfprc6 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPRC6);
                                    if(xfprc6 != null && xfprc6.trim() != ''){
                                        detail6.FundPrice = decimal.valueOf(double.valueOf(xfprc6));
                                    }
                                    else{
                                        detail6.FundPrice = 0;
                                    }
                                    string xfalc6 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFALC6);
                                    if(xfalc6 != null && xfalc6.trim() != ''){
                                        detail6.FundAllocation = decimal.valueOf(double.valueOf(xfalc6));
                                    }
                                    else{
                                        detail6.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail6);
                                    temp5 = val5;
                                }
                                
                                //Fund Detail (total & NAV date)
                                string xtotal = bacaString(ambilRLS.PolicyDetailsRLS[i].XTOTAL);
                                if(xtotal != null && xtotal.trim() != ''){
                                    detailFund.TotFundAmount = decimal.valueOf(double.valueOf(xtotal));
                                }
                                else{
                                    detailFund.TotFundAmount = 0;
                                }
                                try{
                                    decimal xnavdt = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].XNAVDT);
                                    if(xnavdt != null && xnavdt != 0){
                                        detailFund.NAVDate = convertStringToDate(String.valueOf(xnavdt));
                                     }
                                    else{
                                        detailFund.NAVDate = null;
                                    }
                                }catch(Exception e){
                                    system.debug('Error in NAV Date (Fund Detail): '+e.getMessage());
                                }
                            
                                //Cash value detail
                                string xloan = bacaString(ambilRLS.PolicyDetailsRLS[i].XLOAN);
                                string xloan1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XLOAN1);
                                string xdvd = bacaString(ambilRLS.PolicyDetailsRLS[i].XDVD);
                                string xdvd1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XDVD1);
                                string xfpd = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPD);
                                string xfpd1 = bacaString(ambilRLS.PolicyDetailsRLS[i].XFPD1);
                                string xcv = bacaString(ambilRLS.PolicyDetailsRLS[i].XCV);
                                
                                val6 = xloan.trim() +'::'+xloan1.trim()+'::'+xdvd.trim()+'::'+xdvd1.trim()+'::'+xfpd.trim()+'::'+xfpd1.trim()+'::'+xcv.trim();
                                system.debug('Val6: ' +val6);
                                
                                if(temp6 != val6){
                                    CashValueDetail cvdetail = new CashValueDetail();
                                    if(xloan != null && xloan.trim() != ''){
                                        cvdetail.Loan = decimal.valueOf(double.valueOf(xloan));
                                    }
                                    else{
                                        cvdetail.Loan = 0;
                                    }
                                    if(xloan1 != null && xloan1.trim() != ''){
                                        cvdetail.LoanInterest = decimal.valueOf(double.valueOf(xloan1));
                                    }
                                    else{
                                        cvdetail.LoanInterest = 0;
                                    }
                                    if(xdvd != null && xdvd.trim() != ''){
                                        cvdetail.Dividend = decimal.valueOf(double.valueOf(xdvd));
                                    }
                                    else{
                                        cvdetail.Dividend = 0;
                                    }
                                    if(xdvd1 != null && xdvd1.trim() != ''){
                                        cvdetail.DividendInterest = decimal.valueOf(double.valueOf(xdvd1));
                                    }
                                    else{
                                        cvdetail.DividendInterest = 0;
                                    }
                                    if(xfpd != null && xfpd.trim() != ''){
                                        cvdetail.FtrPremDeposit = decimal.valueOf(double.valueOf(xfpd));
                                    }
                                    else{
                                        cvdetail.FtrPremDeposit = 0;
                                    }
                                    if(xfpd1 != null && xfpd1.trim() != ''){
                                        cvdetail.FtrPremDepInter = decimal.valueOf(double.valueOf(xfpd1));
                                    }
                                    else{
                                        cvdetail.FtrPremDepInter = 0;
                                    }
                                    if(xcv != null && xcv.trim() != ''){
                                        cvdetail.CashValue = decimal.valueOf(double.valueOf(xcv));
                                    }
                                    else{
                                        cvdetail.CashValue = 0;
                                    }
                                    cashValueList.add(cvdetail);
                                    temp6 = val6;
                                }
                                
                                //Premium Breakdown
                                string plncode = bacaString(ambilRLS.PolicyDetailsRLS[i].PLNCODE);
                                string plnatch = bacaString(ambilRLS.PolicyDetailsRLS[i].PLNATCH);
                                string plntyp = bacaString(ambilRLS.PolicyDetailsRLS[i].PLNTYP);
                                string plncls = bacaString(ambilRLS.PolicyDetailsRLS[i].PLNCLS);
                                string plnsts = bacaString(ambilRLS.PolicyDetailsRLS[i].PLNSTS);
                                decimal planmprem = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].PLANMPREM);
                                decimal plnsi = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].PLNSI);
                                decimal plneff = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].PLNEFF);
                                decimal plnexp = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].PLNEXP);
                                
                                val7 = plncode.trim() +'::'+plnatch.trim() +'::'+string.valueOf(planmprem).trim() +'::'+plntyp.trim()+'::'+String.valueOf(plneff).trim()+'::'
                                       +String.valueOf(plnsi).trim()+'::'+plncls.trim()+'::'+string.valueOf(plnexp).trim() +'::'+plnsts.trim();
                                
                                system.debug('Val7: ' +val7);
                                
                                if(temp7 != val7){
                                    PremiumBreakdown prembreak = new PremiumBreakdown();
                                    prembreak.PlanCode = plncode;
                                    if(plnatch != null && plnatch.trim() != ''){
                                        prembreak.BasicPlan = decimal.valueOf(plnatch);
                                    }
                                    else{
                                        prembreak.BasicPlan = 0;
                                    }
                                    if(planmprem != null){
                                        prembreak.ModalPlanPremium = planmprem;
                                    }
                                    else{
                                         prembreak.ModalPlanPremium = 0;
                                    }
                                    prembreak.PlanType = plntyp;
                                    prembreak.ClassCode = plncls;
                                    if(plnsi != null && plnsi != 0){
                                        prembreak.PlanSi = plnsi;
                                    }
                                    else{
                                        prembreak.PlanSi = 0;
                                    }
                                    try{
                                        if(plneff != null && plneff != 0){
                                            prembreak.EffectiveDate = convertStringToDate(String.valueOf(plneff));
                                        }
                                        else{
                                            prembreak.EffectiveDate = null;
                                        }
                                        if(plnexp != null && plnexp != 0){
                                            prembreak.ExpiredDate = convertStringToDate(String.valueOf(plnexp));
                                        }
                                        else{
                                            prembreak.ExpiredDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in Premium Breakdown: '+e.getMessage());
                                    }
                                    prembreak.PlanStatus = plnsts;
                                    premiumBreakdownList.add(prembreak);    
                                    temp7 = val7;
                                }
                                
                                //Account Detail
                                string bankcod = bacaString(ambilRLS.PolicyDetailsRLS[i].BANKCOD);
                                string baccnt = bacaString(ambilRLS.PolicyDetailsRLS[i].BACCNT);
                                string btype = bacaString(ambilRLS.PolicyDetailsRLS[i].BTYPE);
                                string bstatus = bacaString(ambilRLS.PolicyDetailsRLS[i].BSTATUS);
                                string bdebtor = bacaString(ambilRLS.PolicyDetailsRLS[i].BDEBTOR);
                                string bcolbank = bacaString(ambilRLS.PolicyDetailsRLS[i].BCOLBANK);
                                string brejcode = bacaString(ambilRLS.PolicyDetailsRLS[i].BREJCODE);
                                string bacneff = bacaString(ambilRLS.PolicyDetailsRLS[i].BACNEFF);
                                string bacnexp = bacaString(ambilRLS.PolicyDetailsRLS[i].BACNEXP);
                                string brejdate = bacaString(ambilRLS.PolicyDetailsRLS[i].BREJDATE);
                                
                                val8 = bankcod.trim() +'::'+baccnt.trim()+'::'+bacneff.trim()+'::'+bacnexp.trim()+'::'+btype.trim()+'::'+
                                       bstatus.trim()+'::'+bdebtor.trim()+'::'+bcolbank.trim()+'::'+brejcode.trim()+'::'+brejdate.trim();
                                                
                                system.debug('Val8: ' +val8);
                                
                                if(temp8 != val8){
                                    AccountDetail accDetail = new AccountDetail();
                                    accDetail.AcchBranch = bankcod;
                                    accDetail.AccountNo = baccnt;
                                    accDetail.AccountType = btype;
                                    accDetail.AccountStatus = bstatus;
                                    accDetail.AccountName = bdebtor;
                                    accDetail.CollectionBank = bcolbank;
                                    accDetail.RejectCode = brejcode;
                                    try{
                                        if(bacneff != null && bacneff.trim() != '' && bacneff.trim() != '0' && bacneff.trim() != '00000000'){
                                            accDetail.AccountEff = convertStringToDate(bacneff);
                                         }
                                        else{
                                            accDetail.AccountEff = null;
                                        }
                                        if(bacnexp != null && bacnexp.trim() != '' && bacnexp.trim() != '0' && bacnexp.trim() != '00000000'){
                                            accDetail.AccountExp = convertStringToDate(bacnexp);
                                         }
                                        else{
                                            accDetail.AccountExp = null;
                                        }
                                        if(brejdate != null && brejdate.trim() != '' && brejdate.trim() != '0' && brejdate.trim() != '00000000'){
                                            accDetail.RejectDate = convertStringToDate(brejdate);
                                         }
                                        else{
                                            accDetail.RejectDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in Account Detail date: '+e.getMessage());
                                    }
                                    accountDetailList.add(accDetail);
                                    temp8 = val8;
                                }
                                
                                /*
                                //Remark Detail
                                val9 = bacaString(ambilRLS.PolicyDetailsRLS[i].PMTYPE).trim() +'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMREF).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKC).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD).trim()+'::'
                                       +bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD2).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD3).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMDEPT).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMUSER).trim()+'::'
                                       +bacaString(ambilRLS.PolicyDetailsRLS[i].PMLUPD).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMCOMD).trim()+'::'+bacaString(ambilRLS.PolicyDetailsRLS[i].PMCOMS).trim();
                                                
                                system.debug('Val9: ' +val9);
                                
                                if(temp9 != val9){
                                    PremiumDetail premDetail = new PremiumDetail();
                                    premDetail.PremiumType = bacaString(ambilRLS.PolicyDetailsRLS[i].PMTYPE);
                                    premDetail.PremRef = bacaString(ambilRLS.PolicyDetailsRLS[i].PMREF);
                                    premDetail.PMRMKC = bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKC);
                                    premDetail.PMRMKD = bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD);
                                    premDetail.PMRMKD2 = bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD2);
                                    premDetail.PMRMKD3 = bacaString(ambilRLS.PolicyDetailsRLS[i].PMRMKD3);
                                    premDetail.PMDEPT = bacaString(ambilRLS.PolicyDetailsRLS[i].PMDEPT);
                                    premDetail.PMUSER = bacaString(ambilRLS.PolicyDetailsRLS[i].PMUSER);
                                    premDetail.PMLUPD = bacaString(ambilRLS.PolicyDetailsRLS[i].PMLUPD);
                                    premDetail.PMCOMD = bacaString(ambilRLS.PolicyDetailsRLS[i].PMCOMD);
                                    premDetail.PMCOMS = bacaString(ambilRLS.PolicyDetailsRLS[i].PMCOMS);
                                    premiumDetailList.add(premDetail);
                                    temp9 = val9;
                                }
                                */
                                
                                //Fund Transaction
                                string ncode = bacaString(ambilRLS.PolicyDetailsRLS[i].NCODE);
                                string nfccy = bacaString(ambilRLS.PolicyDetailsRLS[i].NFCCY);
                                string ntcod = bacaString(ambilRLS.PolicyDetailsRLS[i].NTCOD);
                                string nptyp = bacaString(ambilRLS.PolicyDetailsRLS[i].NPTYP);
                                string npmod = bacaString(ambilRLS.PolicyDetailsRLS[i].NPMOD);
                                decimal namtp = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NAMTP);
                                decimal nsprd = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NSPRD);
                                decimal nuprc = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NUPRC);
                                decimal nfprd = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NFPRD);
                                decimal nuprd = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NUPRD);
                                decimal ntdat = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NTDAT);
                                decimal neffd = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NEFFD);
                                decimal namtu = bacaDecimal(ambilRLS.PolicyDetailsRLS[i].NAMTU);
                                
                                val10 = string.ValueOf(neffd).trim() +'::'+string.valueOf(ntdat).trim()+'::'+nptyp.trim()+'::'
                                        +ntcod.trim()+'::'+nfccy.trim()+'::'+string.valueOf(nfprd).trim()+'::'+string.valueOf(nuprd).trim()+'::'
                                        +ncode.trim()+'::'+string.valueOf(nuprc).trim()+'::'+string.valueOf(nsprd).trim()+'::'+string.valueOf(namtp).trim()+'::'
                                        +string.valueOf(namtu).trim()+'::'+npmod.trim();
                                
                                system.debug('Val10: ' +val10);
                                
                                if(temp10 != val10){
                                    FundTransaction fundtrx = new FundTransaction();
                                    fundtrx.FundCodes = ncode;
                                    fundtrx.UnitPrice = nuprc;
                                    fundtrx.FundCurrency = nfccy;
                                    fundtrx.Spread = string.valueOf(nsprd);
                                    fundtrx.TrxCode = ntcod;
                                    fundtrx.TrxAmount = namtp;
                                    fundtrx.TrxUnit = namtu;
                                    fundtrx.ProcessingType = nptyp; 
                                    fundtrx.ProcessingMode = npmod;
                                    try{
                                        if(nfprd != null && nfprd != 0){
                                            fundtrx.FundPriceDate = convertStringToDate(string.valueOf(nfprd));
                                        }
                                        else{
                                            fundtrx.FundPriceDate = null;
                                        }
                                        if(nuprd != null && nuprd != 0){
                                            fundtrx.ValuationDate = convertStringToDate(string.valueOf(nuprd));
                                        }
                                        else{
                                            fundtrx.ValuationDate = null;
                                        }
                                        if(ntdat != null && ntdat != 0){
                                            fundtrx.TrxDate = convertStringToDate(string.valueOf(ntdat));
                                        }
                                        else{
                                            fundtrx.TrxDate = null;
                                        }
                                        if(neffd != null && neffd != 0){
                                            fundtrx.TrxEffectiveDate = convertStringToDate(string.valueOf(neffd));
                                        }
                                        else{
                                            fundtrx.TrxEffectiveDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in fund transaction date: '+e.getMessage());
                                    }
                                    fundTrxList.add(fundtrx);
                                    temp10 = val10;
                                }
                                system.debug('Finish for RLS....');             
                            }
                        }
                    }
                }catch(Exception e){
                    system.debug('System error (return from WSDL): '+errorDSRTN);
                }
            }
            //PolicyApp = nonRLS (Clipper, DMTM, BIS)
            else if(tipe == 'Non RLS 1' || tipe == 'Non RLS 2' || tipe == 'Non RLS 3'){
                displayRLSOnly = false;
                AdditionalNonRLS = true;
                
                if(!Test.isRunningTest()){
                    ambilNonRLSALI = srv.GetPolicyDetailsNonRLSALI(contactRec.Policy_No_ALI__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                }
                //CCCWebserviceConnectors10Ali.ArrayOfPolicyDetailsNonRLSALI ambil = srv.GetPolicyDetailsLifeNonRLS(contactRec.Policy_No_ALI__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                
                //applogWs.end_date__c = system.now();
                applogWs.EndLongTime__c = system.now().getTime();
                applogWs.method__c = 'call webservice : CCCWebserviceConnectors10Ali.GetPolicyDetailsNonRLSALI()';
                
                try{    
                    if(ambilNonRLSALI != null){
                        system.debug('start here (Non RLS)...');
                        
                        panjang = ambilNonRLSALI.PolicyDetailsNonRLSALI.size();
                        
                        if(panjang > 0){
                            String temp1 = '';
                            String temp2 = '';
                            String temp3 = '';
                            String temp4 = '';
                            String temp5 = '';
                            String temp6 = '';
                            String temp7 = '';
                            String temp8 = '';
                            String tempcard = '';
                            String tempRHS = '';
                            String tempPH = '';
                            Integer countRHS = 0;
                                
                            for(integer i=0;i<panjang;i++){
                                errorDSRTN = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].DESRTN);
                                system.debug('ErrorDSRTN: '+errorDSRTN);
                                
                                if(errorDSRTN != null && errorDSRTN != '' && (!errorDSRTN.contains('Sukses')) && (!errorDSRTN.contains('SUKSES'))){
                                    ApexPages.Message errEmail = new ApexPages.Message(ApexPages.Severity.ERROR,'There is error on web service. Please contact administrator.'); 
                                    ApexPages.addMessage(errEmail);
                                    isDisplayed = false;
                                    displayGIOnly = false;
                                    break;
                                }
                                if(i==0){
                                    pelanggan.CustomerID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_ID);
                                    if(pelanggan.CustomerID == '0'){
                                        pelanggan.CustomerID = '';
                                    }
                                    pelanggan.Name =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_NAME); 
                                    pelanggan.PlaceofBirth =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_PLACEOFBIRTH);
                                    if(pelanggan.PlaceofBirth == '0'){
                                        pelanggan.PlaceofBirth = '';
                                    }
                                    try{
                                        string policyowner_dob = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_DOB);
                                        if(policyowner_dob != null && policyowner_dob.trim() != '' && policyowner_dob.trim() != '0' && policyowner_dob.trim() != '00000000'){
                                            pelanggan.DOB = convertStringToDate(policyowner_dob);
                                         }
                                        else{
                                            pelanggan.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in DOB: '+e.getMessage());
                                    }
                                    pelanggan.Gender = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_GENDER);
                                    pelanggan.Alamat1 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_ADDRESS1);
                                    pelanggan.Alamat2 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_ADDRESS2);
                                    pelanggan.Alamat3 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_ADDRESS3);
                                    pelanggan.Alamat4 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_ADDRESS4);
                                    pelanggan.EmailAddress = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_EMAIL);
                                    pelanggan.AgentServicing = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_SERVICING);
                                    pelanggan.AgentProducer = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_PRODUCER);
                                    // new ALI
                                    //*
                                    pelanggan.MobilePhone2 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_MOBILEPHONE2);
                                    pelanggan.IdentityNo = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_IDENTITYNO);
                                    pelanggan.IdentityTypeID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_IDENTITYTYPE);

                                    pelanggan.ZipCode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_ZIPCODE);
                                    pelanggan.City = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_CITY);
                                    pelanggan.Province = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_PROVINCE);
                                    pelanggan.CardNo = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_CARDNO);
                                    pelanggan.AccountNo = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_ACCOUNTNO);
                                    pelanggan.CardName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_CARDNAME);
                                    pelanggan.AccountName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_ACCOUNTNAME);
                                    pelanggan.BankName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_BANKNAME);
                                    pelanggan.CardExpire = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICYOWNER_CARDEXPIRE);
                                    
                                    // set total = 0, untuk default awal.
                                    pelanggan.TotalNotPaid = 0;
                                    pelanggan.CountPayment = 0;
                                    pelanggan.CountPaid = 0;
                                    pelanggan.CountNotPaid = 0;
                                    pelanggan.CountClaim = 0;
                                    pelanggan.CountSFDC_PH = 0;
                                    pelanggan.CountSFDC_PH = 0;
                                    pelanggan.CountSFDC_Payment = 0;
                                    
                                    try{
                                        string policyowner_dob = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENT_BLACKLISTDATE);
                                        if(policyowner_dob != null && policyowner_dob.trim() != '' && policyowner_dob.trim() != '0' && policyowner_dob.trim() != '00000000'){
                                            pelanggan.BlacklistDate = convertStringToDate(policyowner_dob);
                                         }
                                        else{
                                            pelanggan.BlacklistDate = null;
                                        }

                                        string Paidtodate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAIDTO_DATE);
                                        if(Paidtodate != null && Paidtodate.trim() != '' && Paidtodate.trim() != '0' && Paidtodate.trim() != '00000000'){
                                            pelanggan.Paidtodate = convertStringToDate(Paidtodate);
                                         }
                                        else{
                                            pelanggan.Paidtodate = null;
                                        }

                                    }catch(Exception e){
                                        system.debug('Error in BlacklistDate: '+e.getMessage());
                                    }
                                    //*/
                                    //Policy Detail
                                    polisRider.PolicyNumber = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICY_NO);
                                    polisRider.ProductCode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PRODUCT_CODE);
                                    polisRider.ProductName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PRODUCT_NAME);
                                    polisRider.PolicyStatus = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].POLICY_STATUS);
                                    if(tipe == 'Non RLS 3'){
                                        polisRider.MataUang = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].REFERENCE_NO);
                                    }
                                    polisRider.TotalPremium = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].TOTAL_MODAL_PREMIUM);
                                    polisRider.TotalSumInsured = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].TOTAL_SI);
                                    polisRider.TotalPremiumofBasicPlan = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BASIC_RIDER_MODPREM);
                                    decimal basic_si = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BASIC_SI);
                                    if(basic_si != null && basic_si != 0){
                                        polisRider.BasicSI = basic_si;
                                    }
                                    else{
                                        polisRider.BasicSI = 0;
                                    }
                                    polisRider.RegularTopUp = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].RTU_PREMIUM);
                                    polisRider.LumpSumTopUp = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].LUMPSUM_PREMIUM);
                                    //polisRider.PaymentMethod = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PPAYMENT_TYPE);
                                    polisRider.PaymentMethod = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_TYPE);
                                    polisRider.PaymentMode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_MODE);
                                    polisRider.Description = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].STATUSDESC);
                                    decimal basic_rider_modprem = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BASIC_RIDER_MODPREM);
                                    if(basic_rider_modprem != null && basic_rider_modprem != 0){
                                        polisRider.BasicRiderModPrem = basic_rider_modprem;
                                    }
                                    else{
                                        polisRider.BasicRiderModPrem = 0;
                                    }
                                    string premiumholiday_start = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PREMIUMHOLIDAY_START);
                                    if(premiumholiday_start.trim() != '' && premiumholiday_start.trim() != '0' && premiumholiday_start.trim() != '00000000'){
                                        polisRider.PremiumHolidayStart = convertStringToDate(premiumholiday_start);
                                    }
                                    else{
                                        polisRider.PremiumHolidayStart = null;
                                    }
                                    string premiumholiday_end = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PREMIUMHOLIDAY_END);
                                    if(premiumholiday_end.trim() != '' && premiumholiday_end.trim() != '0' && premiumholiday_end.trim() != '00000000'){
                                        polisRider.PremiumHolidayEnd = convertStringToDate(premiumholiday_end);
                                    }
                                    else{
                                        polisRider.PremiumHolidayEnd = null;
                                    }
                                    polisRider.FundPrice = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDTOTAL);
                                    decimal cash_value = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CASH_VALUE);
                                    if(cash_value != null && cash_value != 0){
                                        polisRider.CashValue = cash_value;
                                    }
                                    else{
                                        polisRider.CashValue = 0;
                                    }
                                    try{
                                        string date_application = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].DATE_APPLICATION);
                                        if(date_application != null && date_application.trim() != '' && date_application.trim() != '0' && date_application.trim() != '00000000'){
                                            polisRider.DateofApplication = convertStringToDate(date_application);
                                        }
                                        else{
                                            polisRider.DateofApplication = null;
                                        }
                                        string issue_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].ISSUE_DATE);
                                        if(issue_date != null && issue_date.trim() != '' && issue_date.trim() != '0' && issue_date.trim() != '00000000'){
                                            polisRider.IssuedDate  = convertStringToDate(issue_date);
                                        }
                                        else{
                                            polisRider.IssuedDate = null;
                                        }
                                        string effective_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].EFFECTIVE_DATE);
                                        if(effective_date != null && effective_date.trim() != '' && effective_date.trim() != '0' && effective_date.trim() != '00000000'){
                                            polisRider.EffectiveDate  = convertStringToDate(effective_date);
                                        }
                                        else{
                                            polisRider.EffectiveDate = null;
                                        }
                                        string expired_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].EXPIRED_DATE);
                                        if(expired_date != null && expired_date.trim() != '' && expired_date.trim() != '0' && expired_date.trim() != '00000000'){
                                            polisRider.ExpiredDate = convertStringToDate(expired_date);
                                        }
                                        else{
                                            polisRider.ExpiredDate = null;
                                        }
                                        string termination_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].TERMINATION_DATE);
                                        if(termination_date != null && termination_date.trim() != '' && termination_date.trim() != '0' && termination_date.trim() != '00000000'){
                                            polisRider.TerminationDate = convertStringToDate(termination_date);
                                        }
                                        else{
                                            polisRider.TerminationDate = null;
                                        }
                                        string due_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].DUE_DATE);
                                        if(due_date != null && due_date.trim() != '' && due_date.trim() != '0' && due_date.trim() != '00000000'){
                                            polisRider.DueDate2 = convertStringToDate(due_date);
                                        }
                                        else{
                                            polisRider.DueDate2 = null;
                                        }
                                        
                                        // new ALI
                                        //*
                                        string cancel_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CANCEL_DATE);
                                        if(cancel_date != null && cancel_date.trim() != '' && cancel_date.trim() != '0' && cancel_date.trim() != '00000000'){
                                            polisRider.CancelDate = convertStringToDate(cancel_date);
                                        }
                                        else{
                                            polisRider.CancelDate = null;
                                        }

                                        string Lapse_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].LAPSE_DATE);
                                        if(Lapse_date != null && Lapse_date.trim() != '' && Lapse_date.trim() != '0' && Lapse_date.trim() != '00000000'){
                                            polisRider.LapseDate = convertStringToDate(Lapse_date);
                                        }
                                        else{
                                            polisRider.LapseDate = null;
                                        }

                                        string Reinstate_Date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].REINSTATE_DATE);
                                        if(Reinstate_Date != null && Reinstate_Date.trim() != '' && Reinstate_Date.trim() != '0' && Reinstate_Date.trim() != '00000000'){
                                            polisRider.ReinstateDate = convertStringToDate(Reinstate_Date);
                                        }
                                        else{
                                            polisRider.ReinstateDate = null;
                                        }

                                        string Create_Date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CREATE_DATE);
                                        if(Create_Date != null && Create_Date.trim() != '' && Create_Date.trim() != '0' && Create_Date.trim() != '00000000'){
                                            polisRider.CreateDate = convertStringToDate(Create_Date);
                                        }
                                        else{
                                            polisRider.CreateDate = null;
                                        }

                                        //*/
                                    }catch(Exception e){
                                        system.debug('Error has occured in date format: '+e.getMessage());
                                    }
                                    // New ALI - Retention Team
                                    polisRider.EffectiveStatus = '';
                                    Date dueDate = Date.Today();
                                    integer RangeDate = NULL;
                                    if (polisRider.EffectiveDate != NULL) 
                                        RangeDate = polisRider.EffectiveDate.daysBetween(dueDate);

                                    if (polisRider.PolicyStatus == 'Inforce' && RangeDate <= 20) polisRider.EffectiveStatus = ' - Cooling Off ('+RangeDate+' days)';
                                    else if (polisRider.PolicyStatus == 'Inforce' && RangeDate > 20) polisRider.EffectiveStatus = ' - Surrender ('+RangeDate+' days)';
                                    else if (polisRider.PolicyStatus == 'Full Paid' && RangeDate <= 20) polisRider.EffectiveStatus = ' - Cooling Off ('+RangeDate+' days)';
                                    else if (polisRider.PolicyStatus == 'Full Paid' && RangeDate > 20) polisRider.EffectiveStatus = ' - Surrender ('+RangeDate+' days)';
                                    else if (polisRider.PolicyStatus == 'Pending') polisRider.EffectiveStatus = 'Cooling Off';
                                    
                                    // new ALI
                                    //*
                                    polisRider.SponsorName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].SPONSOR_NAME);
                                    polisRider.CorrespondenceTypeID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CORRESPONDENCE_TYPE);
                                    polisRider.CampaignProgramName = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CAMPAIGN_PROGRAM);
                                    polisRider.DigitaPolicyID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].DIGITAL_POLICY);
                                    polisRider.AgentID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ID);
                                    //*/
                                    
                                    //Agent Info
                                    agen.AgentNo =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENTNO);
                                    agen.DistributionCode =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_DIST_CODE);
                                    agen.DistributionType =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_DIST_TYPE);
                                    agen.AgentName =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_NAME);
                                    agen.AgentID =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ID);
                                    try{
                                        string agent_joindate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_JOINDATE);
                                        if(agent_joindate.trim() != '' && agent_joindate.trim() != null && agent_joindate.trim() != '0' && agent_joindate.trim() != '00000000'){
                                                agen.JoinDate = convertStringToDate(agent_joindate);
                                            }
                                        else{
                                            agen.JoinDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured join date (Agent Info section): '+e.getMessage());
                                    }
                                    agen.Status =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_STATUS);
                                    agen.Area =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_AREA);
                                    agen.HomeAddress1 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ADDRESS1);
                                    agen.HomeAddress2 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ADDRESS2);
                                    agen.HomeAddress3 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ADDRESS3);
                                    agen.HomeAddress4 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_ADDRESS4);
                                    agen.OfficeAddress1 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_OFF_ADDRESS1);
                                    agen.OfficeAddress2 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_OFF_ADDRESS2);
                                    agen.OfficeAddress3 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_OFF_ADDRESS3);
                                    agen.OfficeAddress4 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_OFF_ADDRESS4);
                                    agen.EmailAddress =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_EMAIL);
                                    agen.HomePhone1 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_HOMEPHONE1);
                                    if(agen.HomePhone1 == '0'){
                                        agen.HomePhone1 = '';
                                    }
                                    agen.HomePhone2 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_HOMEPHONE2);
                                    if(agen.HomePhone2 == '0'){
                                        agen.HomePhone2 = '';
                                    }
                                    agen.OfficePhone =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_OFFICEPHONE);
                                    if(agen.OfficePhone == '0'){
                                        agen.OfficePhone = '';
                                    }
                                    agen.MobilePhone1 =  bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AGENT_MOBILE);
                                    if(agen.MobilePhone1 == '0'){
                                        agen.MobilePhone1 = '';
                                    }
                                }   
                                
                                //Insured
                                string insured_name = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_NAME);
                                string insured_placeofbirth = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_PLACEOFBIRTH);
                                string insured_dob = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_DOB);
                                string insured_gender = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_GENDER);
                                string insured_id = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_ID);
                                string insured_email = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_EMAIL);
                                string insured_mobile = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_MOBILE);
                                string relation_with_pholder = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].RELATION_WITH_POLICYHOLDER);
                                
                                // new ALI
                                //*
                                string insured_PlanID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_PLAN);
                                string insured_StatusID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_STATUS);
                                string insured_Premium = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_PREMIUM);
                                string insured_RelationshipID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_RELATION);
                                string insured_TypeID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSURED_TYPE);
                                //*/
                                val1 = insured_name.trim()+'::'+insured_placeofbirth.trim()+'::'+insured_dob.trim()+'::'+insured_gender.trim()+'::'
                                       +insured_id.trim()+'::'+insured_email.trim()+'::'+insured_mobile.trim()+'::'+relation_with_pholder.trim();
                                
                                system.debug('Val1: ' +val1);
                                
                                if(temp1 != val1){
                                    Insured tertanggung = new Insured(); 
                                    tertanggung.Name = insured_name;
                                    tertanggung.PlaceofBirth = insured_placeofbirth;
                                    if(tertanggung.PlaceofBirth == '0'){
                                        tertanggung.PlaceofBirth = '';
                                    }
                                    try{
                                        if(insured_dob != null && insured_dob.trim() != '' && insured_dob.trim() != '0' && insured_dob.trim() != '00000000'){
                                            tertanggung.DOB = convertStringToDate(insured_dob);
                                        }
                                        else{
                                            tertanggung.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in insured DOB: '+e.getMessage());
                                    }
                                    
                                    tertanggung.Gender = insured_gender;
                                    tertanggung.IdentificationNo = insured_id;
                                    if(tertanggung.IdentificationNo == '0'){
                                        tertanggung.IdentificationNo = '';
                                    }
                                    tertanggung.EmailAddress = insured_email;
                                    if(tertanggung.EmailAddress == '0'){
                                        tertanggung.EmailAddress = '';
                                    }
                                    tertanggung.MobilePhoneNumber = insured_mobile;
                                    if(tertanggung.MobilePhoneNumber == '0'){
                                        tertanggung.MobilePhoneNumber = '';
                                    }
                                    tertanggung.RelationwithPolicyHolder = relation_with_pholder;

                                    // new ALI
                                    //*
                                    tertanggung.PlanID = insured_PlanID;
                                    tertanggung.StatusID = insured_StatusID;
                                    //tertanggung.Premium = insured_Premium;
                                    tertanggung.RelationshipID = insured_RelationshipID;
                                    tertanggung.TypeID = insured_TypeID;
                                    if (insured_Premium == NULL ) insured_Premium = '';
                                    if(insured_Premium.trim() != '' && insured_Premium.trim() != '0'){
                                        
                                        tertanggung.Premium = decimal.valueOf(double.valueOf(insured_Premium));
                                    }
                                    else{
                                        tertanggung.Premium = 0;
                                    }
                                    //*/
                                    date datetoday = date.today();
                                    if (tertanggung.DOB != NULL)
                                    tertanggung.Age = string.valueof (datetoday.year() - tertanggung.DOB.year()) ;

                                    insuredList.add(tertanggung);
                                    temp1 = val1;
                                }
                                
                                //Payment history
                                string payment_type = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_TYPE);
                                string payment_sub_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_SUB_DATE);
                                string payment_txn_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_TXN_DATE);
                                string payment_duedate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_DUEDATE);
                                string payment_amount = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_AMOUNT);

                                // New ALI
                                //*
                                string REFFERENCE_NO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_REFFERENCE);
                                string ACCOUNT_NO = ''; //bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_ACCOUNTNO);
                                string CARD_NO = ''; //bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_CARDNO);
                                string PAYMENT_ACCOUNTNAME = ''; //bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_ACCOUNTNAME);
                                string PAYMENT_CARDNAME = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_CARDNAME);
                                string PAYMENT_BANK = ''; // bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_BANK);
                                string PAYMENT_CARDEXPIRE = ''; //bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_CARDEXPIRE);
                                string PAYMENT_Status = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_STATUS);
                                string PAYMENT_BILLINGNO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_BILLINGNO);
                                string PAYMENT_DATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_DATE);
                                string PAYMENT_AGE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_AGE);
                                string PAYMENT_MONTHSBILLED = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_MONTHSBILLED);
                                string PAYMENT_POLICYNO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_POLICYNO);
                                string PAYMENT_PRODUCT = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_PRODUCT);
                                string PAYMENT_AUTHCODE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_AUTHCODE);
                                string PAYMENT_REMARK = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_REMARK);
                                string PAYMENT_COUNT_PAID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_COUNT_PAID);
                                string PAYMENT_COUNT_NOT_PAID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PAYMENT_COUNT_NOT_PAID);
                                //*/

                                //val2 = payment_type.trim() +'::'+payment_sub_date.trim() +'::'+payment_txn_date.trim()+'::'+payment_duedate.trim()+'::'+payment_amount.trim();
                                if (payment_type == NULL || PAYMENT_BILLINGNO == NULL || payment_amount == NULL)
                                    val2 = '';
                                else
                                    val2 = payment_type.trim() +'::'+PAYMENT_BILLINGNO.trim()+'::'+payment_amount.trim();
                                system.debug('Val2 = ' +val2);
                                
                                if(temp2 != val2){
                                    TrxPayment payment = new TrxPayment();
                                    payment.TransactionType = payment_type;
                                    // new ALI
                                    //*
                                    payment.REFFERENCENO = REFFERENCE_NO;
                                    payment.ACCOUNTNO = ACCOUNT_NO;
                                    payment.CARDNO = CARD_NO;
                                    payment.ACCOUNTNAME = PAYMENT_ACCOUNTNAME;
                                    payment.CARDNAME = PAYMENT_CARDNAME;
                                    payment.BANK = PAYMENT_BANK;
                                    payment.CARDEXPIRE = PAYMENT_CARDEXPIRE;
                                    payment.Status = PAYMENT_Status;
                                    PAYMENT.BILLINGNO = PAYMENT_BILLINGNO;
                                    PAYMENT.AGE = PAYMENT_AGE;
                                    PAYMENT.MONTHSBILLED = PAYMENT_MONTHSBILLED;
                                    PAYMENT.POLICYNO = PAYMENT_POLICYNO;
                                    PAYMENT.PRODUCT = PAYMENT_PRODUCT;
                                    PAYMENT.AUTHCODE = PAYMENT_AUTHCODE;
                                    PAYMENT.REMARK = PAYMENT_REMARK;
                                    
                                    if (payment.TransactionType != 'DEBIT BANK ACCOUNT' && payment.TransactionType != 'DBB' && payment.CARDNO.length() > 10) 
                                        payment.CARDNO = payment.CARDNO.left(6)+'xxxxxx'+payment.CARDNO.right(payment.CARDNO.length()-12);
                                    //*/
                                    if(PAYMENT_COUNT_PAID.trim() != '' && PAYMENT_COUNT_PAID.trim() != '0'){
                                        PAYMENT.COUNT_PAID = integer.valueOf(double.valueOf(PAYMENT_COUNT_PAID));
                                    }
                                    else{
                                        PAYMENT.COUNT_PAID = 0;
                                    }
                                    if(PAYMENT_COUNT_NOT_PAID.trim() != '' && PAYMENT_COUNT_NOT_PAID.trim() != '0'){
                                        PAYMENT.COUNT_NOT_PAID = integer.valueOf(double.valueOf(PAYMENT_COUNT_NOT_PAID));
                                    }
                                    else{
                                        PAYMENT.COUNT_NOT_PAID = 0;
                                    }

                                    try{
                                        if(payment_sub_date.trim() != '' && payment_sub_date != null && payment_sub_date.trim() != '0' && payment_sub_date.trim() != '00000000'){
                                            payment.SubmissionDate = convertStringToDate(payment_sub_date);
                                        }
                                        else{
                                            payment.SubmissionDate = null;
                                        }
                                        if(payment_txn_date.trim() != '' && payment_txn_date != null && payment_txn_date.trim() != '0' && payment_txn_date.trim() != '00000000'){
                                            payment.PaymentDate = convertStringToDate(payment_txn_date);
                                        }
                                        else{
                                            payment.PaymentDate = null;
                                        }
                                        if(payment_duedate.trim() != '' && payment_duedate != null && payment_duedate.trim() != '0' && payment_duedate.trim() != '00000000'){
                                            payment.DueDate = convertStringToDate(payment_duedate);
                                        }
                                        else{
                                            payment.DueDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    if(payment_amount.trim() != '' && payment_amount.trim() != '0'){
                                        payment.Amount = decimal.valueOf(double.valueOf(payment_amount));
                                    }
                                    else{
                                        payment.Amount = 0;
                                    }
                                    
                                    // summary payment amount 
                                    if (payment.Status != NULL && payment.Status != '') {
                                        //pelanggan.CountPayment += 1;
                                        if (payment.Status == 'Not Paid') {
                                            pelanggan.TotalNotPaid += payment.Amount;
                                            //pelanggan.CountPaid += 1;
                                        }
                                        if (i == 0) {
                                            pelanggan.CountPaid = PAYMENT.COUNT_PAID;
                                            pelanggan.CountNotPaid = PAYMENT.COUNT_NOT_PAID;
                                            pelanggan.CountPayment = pelanggan.CountPaid + pelanggan.CountNotPaid;
                                        }
                                    }
                                    
                                    if ( payment.REFFERENCENO != '') trxPaymentList.add(payment);
                                    if ( trxPaymentList.size() < 5) trxPaymentList5.add(payment);
                                    
                                    // Distinct Payment Info, berdasarkan CardNo
                                    if (tempcard != payment.CARDNO) {
                                        tempcard = payment.CARDNO;
                                        trxPayInfoList.add(payment);
                                    }
                                    
                                    temp2 = val2;
                                } 

                                //Policy history
                                // New ALI
                                //*
                                string ph_UserID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].History_UserId);
                                string ph_EventDate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].EventDate);
                                string ph_EventType = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].History_EventType);
                                string ph_Description = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].Description);
                                string ph_PolicyStatus = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PolicyStatus);
                                string ph_Remark = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].Remark);
                                //*/

                                if (ph_UserID == NULL || ph_EventDate == NULL || ph_EventType == NULL || ph_Description == NULL || ph_PolicyStatus == NULL)
                                    valph = '';
                                else
                                    valph = ph_UserID.trim() +'::'+ph_EventDate.trim() +'::'+ph_EventType.trim()+'::'+ph_Description.trim()+'::'+ph_PolicyStatus.trim();
                                system.debug('Valph = ' +valph);
                                
                                if(tempph != valph){
                                    TrxPolicyHistory ph = new TrxPolicyHistory();
                                    // new ALI
                                    //*
                                    ph.UserID = ph_UserID;
                                    //ph.EventDate = ph_EventDate;
                                    ph.EventType = ph_EventType;
                                    ph.Description = ph_Description;
                                    ph.PolicyStatus = ph_PolicyStatus;
                                    ph.Remark = ph_Remark;                                    
                                    //*/

                                    try{
                                        if(ph_EventDate.trim() != '' && ph_EventDate != null && ph_EventDate.trim() != '0' && ph_EventDate.trim() != '00000000'){
                                            ph.EventDate = convertStringToDate(ph_EventDate);
                                        }
                                        else{
                                            ph.EventDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                                                        
                                    TrxPolicyHistoryList.add(ph);
                                    if ( TrxPolicyHistoryList.size() < 5) TrxPolicyHistoryList5.add(ph);
                                                                        
                                    tempph = valph;
                                } 
                                
                                //Claim history
                                string claim_number = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_NUMBER);
                                string claim_amount = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_AMOUNT);
                                string claim_status = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_STATUS);
                                string claim_submission_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_SUBMISSION_DATE);
                                string claim_approval_date = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_APPROVAL_DATE);
                                string statusdesc = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].STATUSDESC);

                                // New Ali
                                string claim_MODIFYDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_MODIFYDATE);
                                string claim_CLAIMANT = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_CLAIMANT);
                                string claim_HOSPITAL = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_HOSPITAL);
                                string claim_ADMISSIONDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_ADMISSIONDATE);
                                string claim_DECISIONDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_DECISIONDATE);
                                
                                string CLAIM_ICUDAYS = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_ICUDAYS);
                                string CLAIM_ISEXGRATIACASE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_ISEXGRATIACASE);
                                string CLAIM_REGULARDAYS = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_REGULARDAYS);
                                
                                string claim_PAYMENTDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_PAYMENTDATE);
                                string claim_ACCOUNTNO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_ACCOUNTNO);
                                string claim_ACCOUNTNAME = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_ACCOUNTNAME);
                                string claim_BANKNAME = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_BANKNAME);
                                string claim_REMARK = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CLAIM_REMARK);
                                
                                if (claim_number == NULL || claim_submission_date == NULL || claim_approval_date == NULL || claim_amount == NULL || claim_status == NULL || statusdesc == NULL)
                                    val3 = '';
                                else
                                    val3 = claim_number.trim()+'::'+claim_submission_date.trim() +'::'+claim_approval_date.trim()+'::'
                                       +claim_amount.trim()+'::'+claim_status.trim()+'::'+statusdesc.trim();
                                
                                system.debug('Val3: ' +val3);
                                
                                if(temp3 != val3){
                                    TrxClaim claim = new TrxClaim();
                                    claim.ClaimNumber = claim_number;
                                    if(claim.ClaimNumber == '0'){
                                        claim.ClaimNumber = '';
                                    }
                                    if(claim_amount.trim() != '' && claim_amount.trim() != '0'){
                                        claim.Amount = decimal.valueOf(double.valueOf(claim_amount));
                                    }
                                    else{
                                        claim.Amount = 0;
                                    } 
                                    claim.ClaimStatus1 = claim_status;
                                    if(claim.ClaimStatus1 == '0'){
                                        claim.ClaimStatus1 = '';
                                    }
                                    claim.StatusDesc = statusdesc;
                                    
                                    // new Ali
                                    claim.MODIFYDATE = CLAIM_MODIFYDATE;
                                    claim.CLAIMANT = CLAIM_CLAIMANT;
                                    claim.HOSPITAL = CLAIM_HOSPITAL;
                                
                                    CLAIM.ICUDAYS = CLAIM_ICUDAYS;
                                    CLAIM.ISEXGRATIACASE = CLAIM_ISEXGRATIACASE;
                                    CLAIM.REGULARDAYS = CLAIM_REGULARDAYS;
                                
                                    claim.ACCOUNTNO = CLAIM_ACCOUNTNO;
                                    claim.ACCOUNTNAME = CLAIM_ACCOUNTNAME;
                                    claim.BANKNAME = CLAIM_BANKNAME;
                                    claim.REMARK = CLAIM_REMARK;
                                    
                                    try{
                                        if(claim_submission_date.trim() != '' && claim_submission_date.trim() != '0' && claim_submission_date.trim() != '00000000'){
                                            claim.SubmissionDate = convertStringToDate(claim_submission_date);
                                        }
                                        else{
                                            claim.SubmissionDate = null;
                                        }
                                        if(claim_approval_date.trim() != '' && claim_approval_date.trim() != '0' && claim_approval_date.trim() != '00000000'){
                                            claim.ApprovalDate = convertStringToDate(claim_approval_date);
                                        }
                                        else{
                                            claim.ApprovalDate = null;
                                        }
                                        // New ALI
                                        if(claim_ADMISSIONDATE.trim() != '' && claim_ADMISSIONDATE.trim() != '0' && claim_ADMISSIONDATE.trim() != '00000000'){
                                            claim.ADMISSIONDATE = convertStringToDate(claim_ADMISSIONDATE);
                                        }
                                        else{
                                            claim.ADMISSIONDATE = null;
                                        }
                                        if(CLAIM_DECISIONDATE.trim() != '' && CLAIM_DECISIONDATE.trim() != '0' && CLAIM_DECISIONDATE.trim() != '00000000'){
                                            CLAIM.DECISIONDATE = convertStringToDate(CLAIM_DECISIONDATE);
                                        }
                                        else{
                                            CLAIM.DECISIONDATE = null;
                                        }
                                        if(CLAIM_PAYMENTDATE.trim() != '' && CLAIM_PAYMENTDATE.trim() != '0' && CLAIM_PAYMENTDATE.trim() != '00000000'){
                                            CLAIM.PAYMENTDATE = convertStringToDate(CLAIM_PAYMENTDATE);
                                        }
                                        else{
                                            CLAIM.PAYMENTDATE = null;
                                        }

                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    if (claim.ClaimNumber != '0' && claim.ClaimNumber != '') { 
                                        trxClaimList.add(claim);  
                                        if ( trxClaimList.size() < 5) trxClaimList5.add(claim);
                                        Pelanggan.CountClaim +=1; 
                                    }
                                    
                                    // new ALI
                                    if (claim.ClaimStatus1 != 'APP' && claim.ClaimStatus1 != 'REJ')
                                        if (claim.ClaimNumber != '0' && claim.ClaimNumber != '') trxOpenLastClaimList.add(claim);   
                                    temp3 = val3;
                                }           
                                // history case, pindah ke paling bawah.
                                
                                // new ALI
                                //*
                                //BackEnd RHS List
                                //string backend_SOURCE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].SOURCE);
                                string backend_SOURCE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CALL_SOURCE);
                                string backend_NOTE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NOTE);
                                //string backend_STATUS = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].STATUS);
                                string backend_STATUS = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].STATUSINQUIRY);
                                system.debug('## ambilNonRLSALI.PolicyDetailsNonRLSALI[i] '+ambilNonRLSALI.PolicyDetailsNonRLSALI[0]);
                                system.debug('## STATUSINQUIRY'+backend_STATUS);
                                string backend_CWC = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NAME);
                                string backend_CREATEBY = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CREATEBY);
                                //string backend_CREATEDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CREATEDATE);
                                string backend_CREATEDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CALL_CREATEDATE);
                                string backend_RETURNCODE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].RETURNCODE);
                                
                                if (backend_SOURCE == NULL || backend_NOTE == NULL || backend_STATUS == NULL ||backend_CWC == NULL || backend_CREATEBY == NULL || backend_CREATEDATE == NULL)
                                    val3 = '';
                                else
                                    val3 = backend_SOURCE.trim()+'::'+backend_NOTE.trim() +'::'+backend_STATUS.trim()+'::'
                                       +backend_CWC.trim()+'::'+backend_CREATEBY.trim()+'::'+backend_CREATEDATE.trim();
                                
                                system.debug('Val3: ' +val3);
                                
                                if(temp3 != val3){
                                    TrxCallNote backend = new TrxCallNote();
                                    backend.SOURCE = backend_SOURCE;
                                    backend.NOTE = backend_NOTE;
                                    backend.STATUS = backend_STATUS;
                                    backend.CWC = backend_CWC;
                                    backend.CREATEBY = backend_CREATEBY;
                                    backend.RETURNCODE = backend_RETURNCODE;
                                    backend.CREATEDATE2 = backend_CREATEDATE;
                                        
                                    try{
                                        if(backend_CREATEDATE.trim() != '' && backend_CREATEDATE.trim() != '0' && backend_CREATEDATE.trim() != '00000000'){
                                            backend.CREATEDATE = convertStringToDate(backend_CREATEDATE);
                                        }
                                        else{
                                            backend.CREATEDATE = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    if (tempRHS != backend.CREATEDATE2) {
                                        trxBackEndRHSList.add(backend);
                                        if ( trxBackEndRHSList.size() < 5) trxBackEndRHSList5.add(backend);
                                        
                                        trxBackEndCHSList.add(backend);
                                        trxBackEndInquiryList.add(backend);
                                        countRHS += 1;
                                        tempRHS = backend.CREATEDATE2;
                                    } else {
                                        trxBackEndRHSList[countRHS-1].CWC += ', '+backend.CWC;
                                    }

                                    temp3 = val3;
                                }           
                                //*/

                                // New ALI
                                //Free PA - FPAPolicy
                                /*
                                string FPA_APPLICATIONNO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].APPLICATIONNO);
                                string FPA_INSUREDNAME = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].INSUREDNAME);
                                string FPA_DATEOFBIRTH = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].DATEOFBIRTH);
                                string FPA_StatusPolis = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].StatusPolis);
                                string FPA_GENDER = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].GENDER);
                                string FPA_ADDRESS = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].ADDRESS);
                                string FPA_RT_RW = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].RT_RW);
                                string FPA_ZipCode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].ZipCode);
                                string FPA_City = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].City);
                                string FPA_Email = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].Email);
                                string FPA_AKTIFDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AKTIFDATE);
                                string FPA_EXPIREDDATE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].EXPIREDDATE);
                                string FPA_AccountNo = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].AccountNo);
                                string FPA_OfficePhone = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].OfficePhone);
                                string FPA_MobilePhone = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].MobilePhone);
                                string FPA_PREMIUMAMOUNT = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PREMIUMAMOUNT);
                                string FPA_SumAssured = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].SumAssured);

                                val2 = FPA_APPLICATIONNO.trim() +'::'+FPA_INSUREDNAME.trim() +'::'+FPA_DATEOFBIRTH.trim()+'::'+FPA_StatusPolis.trim()+'::'+FPA_GENDER.trim();
                                system.debug('Val2 = ' +val2);
                                
                                if(temp2 != val2){
                                    FPAPolicy FPA = new FPAPolicy();
                                    FPA.APPLICATIONNO = FPA_APPLICATIONNO;
                                    FPA.INSUREDNAME = FPA_INSUREDNAME;
                                    FPA.StatusPolis = FPA_StatusPolis;
                                    FPA.GENDER = FPA_GENDER;
                                    FPA.ADDRESS = FPA_ADDRESS;
                                    FPA.RT_RW = FPA_RT_RW;
                                    FPA.ZipCode = FPA_ZipCode;
                                    FPA.City = FPA_City;
                                    FPA.Email = FPA_Email;
                                    FPA.AccountNo = FPA_AccountNo;
                                    FPA.OfficePhone = FPA_OfficePhone;
                                    FPA.MobilePhone = FPA_MobilePhone;
                                    FPA.SumAssured = FPA_SumAssured;

                                    try{

                                        if(FPA_DATEOFBIRTH.trim() != '' && FPA_DATEOFBIRTH != null && FPA_DATEOFBIRTH.trim() != '0' && FPA_DATEOFBIRTH.trim() != '00000000'){
                                            FPA.DATEOFBIRTH = convertStringToDate(FPA_DATEOFBIRTH);
                                        }
                                        else{
                                            FPA.DATEOFBIRTH = null;
                                        }
                                        if(FPA_AKTIFDATE.trim() != '' && FPA_AKTIFDATE != null && FPA_AKTIFDATE.trim() != '0' && FPA_AKTIFDATE.trim() != '00000000'){
                                            FPA.AKTIFDATE = convertStringToDate(FPA_AKTIFDATE);
                                        }
                                        else{
                                            FPA.AKTIFDATE = null;
                                        }
                                        if(FPA_EXPIREDDATE.trim() != '' && FPA_EXPIREDDATE != null && FPA_EXPIREDDATE.trim() != '0' && FPA_EXPIREDDATE.trim() != '00000000'){
                                            FPA.EXPIREDDATE = convertStringToDate(FPA_EXPIREDDATE);
                                        }
                                        else{
                                            FPA.EXPIREDDATE = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }

                                    if(FPA_PREMIUMAMOUNT.trim() != '' && FPA_PREMIUMAMOUNT.trim() != '0'){
                                        FPA.PREMIUMAMOUNT = decimal.valueOf(double.valueOf(FPA_PREMIUMAMOUNT));
                                    }
                                    else{
                                        FPA.PREMIUMAMOUNT = 0;
                                    }
                                    FPAPolicyList.add(FPA);
                                    temp2 = val2;
                                } 
                                //*/

                                // New ALI
                                //Free PA - FPABeneficiary
                                /*
                                string FPAB_APPLICATIONNO = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].APPLICATIONNO);
                                string FPAB_BENEFICIARYNAME = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARYNAME);
                                string FPAB_BENEFICIARYDOB = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARYDOB);
                                string FPAB_BENEFICIARYGENDER = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARYGENDER);
                                string FPAB_BENEFICIARYRELATION = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARYRELATION);
                                string FPAB_BENEFICIARYPERCENTAGE = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARYPERCENTAGE);

                                val2 = FPAB_APPLICATIONNO.trim() +'::'+FPAB_BENEFICIARYNAME.trim() +'::'+FPAB_BENEFICIARYDOB.trim()+'::'+FPAB_BENEFICIARYGENDER.trim()+'::'+FPAB_BENEFICIARYRELATION.trim();
                                system.debug('Val2 = ' +val2);
                                
                                if(temp2 != val2){
                                    FPABeneficiary FPAB = new FPABeneficiary();
                                    FPAB.APPLICATIONNO = FPAB_APPLICATIONNO;
                                    FPAB.BENEFICIARYNAME = FPAB_BENEFICIARYNAME;
                                    FPAB.BENEFICIARYDOB = FPAB_BENEFICIARYDOB;
                                    FPAB.BENEFICIARYGENDER = FPAB_BENEFICIARYGENDER;
                                    FPAB.BENEFICIARYRELATION = FPAB_BENEFICIARYRELATION;
                                    FPAB.BENEFICIARYPERCENTAGE = FPAB_BENEFICIARYPERCENTAGE;

                                    try{

                                        if(FPAB_BENEFICIARYDOB.trim() != '' && FPAB_BENEFICIARYDOB != null && FPAB_BENEFICIARYDOB.trim() != '0' && FPAB_BENEFICIARYDOB.trim() != '00000000'){
                                            FPAB.BENEFICIARYDOB = convertStringToDate(FPAB_BENEFICIARYDOB);
                                        }
                                        else{
                                            FPAB.BENEFICIARYDOB = null;
                                        }

                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    FPABeneficiaryList.add(FPAB);
                                    temp2 = val2;
                                } 
                                //*/
                                
                                //Beneficiary
                                string beneficiary_name = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_NAME);
                                string beneficiary_dob = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_DOB);
                                string beneficiary_placedob = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_PLACEDOB);
                                string beneficiary_gender = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_GENDER);
                                string beneficiary_relation = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_RELATION);
                                decimal beneficiary_percentage = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].BENEFICIARY_PERCENTAGE);

                                // jika FreePA, hanya Name dan DOB.
                                if (PolicyApp == 'FreePA')
                                val4 = beneficiary_name.trim() +'::'+beneficiary_dob.trim();
                                else
                                val4 = beneficiary_name.trim() +'::'+beneficiary_dob.trim()+'::'+beneficiary_placedob.trim()+'::'+beneficiary_gender.trim()+'::'
                                       +beneficiary_relation.trim()+'::'+String.valueOf(beneficiary_percentage).trim();                                
                                system.debug('Val4: ' +val4);
                                
                                if(temp4 != val4){
                                    Beneficiary benefit = new Beneficiary();
                                    benefit.Name = beneficiary_name;
                                    try{
                                        if(beneficiary_dob.trim() != '' && beneficiary_dob.trim() != '0' && beneficiary_dob.trim() != '00000000'){
                                            benefit.DOB = convertStringToDate(beneficiary_dob);
                                        }
                                        else{
                                            benefit.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in Beneficiary DOB: '+e.getMessage());
                                    }
                                    benefit.PlaceofBirth = beneficiary_placedob;
                                    if(benefit.PlaceofBirth == '0'){
                                        benefit.PlaceofBirth = '';
                                    }
                                    benefit.Gender = beneficiary_gender;
                                    benefit.RelationwithInsured = beneficiary_relation;
                                    benefit.PercentageofBenefit = string.valueOf(beneficiary_percentage);
                                    if (benefit.name != '0' && benefit.name != '') beneficiaryList.add(benefit);
                                    temp4 = val4;
                                }
                                
                                //Fund Detail
                                string fundcode1 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDCODE1);
                                string fundunit1 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDUNIT1);
                                string fundprice1 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDPRICE1);
                                string fundamount1 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDAMOUNT1);
                                
                                if (fundcode1 == NULL || fundunit1 == NULL || fundprice1 == NULL || fundamount1 == NULL)
                                    val5 = '';
                                else
                                val5 = fundcode1.trim() +'::'+fundunit1.trim()+'::'+fundprice1.trim()+'::'+fundamount1.trim();
                                system.debug('Val5: ' +val5);
                                
                                if(temp5 != val5){
                                    DetailFund detail1 = new DetailFund();
                                    detail1.FundCode = fundcode1;
                                    if(fundunit1 != null && fundunit1.trim() != ''){
                                        detail1.TotalUnitFund = decimal.valueOf(double.valueOf(fundunit1));
                                    }
                                    else{
                                        detail1.TotalUnitFund = 0;
                                    }
                                    if(fundprice1 != null && fundprice1.trim() != ''){
                                        detail1.FundPrice = decimal.valueOf(double.valueOf(fundprice1));
                                    }
                                    else{
                                        detail1.FundPrice = 0;
                                    }
                                    if(fundamount1 != null && fundamount1.trim() != ''){
                                        detail1.FundAllocation = decimal.valueOf(double.valueOf(fundamount1));
                                    }
                                    else{
                                        detail1.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail1);
                                    DetailFund detail2 = new DetailFund();
                                    detail2.FundCode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDCODE2);
                                    string fundunit2 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDUNIT2);
                                    if(fundunit2 != null && fundunit2.trim() != ''){
                                        detail2.TotalUnitFund = decimal.valueOf(double.valueOf(fundunit2));
                                    }
                                    else{
                                        detail2.TotalUnitFund = 0;
                                    }
                                    string fundprice2 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDPRICE2);
                                    if(fundprice2 != null && fundprice2.trim() != ''){
                                        detail2.FundPrice = decimal.valueOf(double.valueOf(fundprice2));
                                    }
                                    else{
                                        detail2.FundPrice = 0;
                                    }
                                    string fundamount2 = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDAMOUNT2);
                                    if(fundamount2 != null && fundamount2.trim() != ''){
                                        detail2.FundAllocation = decimal.valueOf(double.valueOf(fundamount2));
                                    }
                                    else{
                                        detail2.FundAllocation = 0;
                                    }
                                    detailFundList.add(detail2);
                                    temp5 = val5;
                                }
                                
                                //Fund Detail (fund total & fund NAV)
                                try{
                                    string fundnav = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDNAV);
                                    if(fundnav.trim() != '' && fundnav.trim() != '0' && fundnav.trim() != '00000000'){
                                        detailFund.NAVDate = convertStringToDate(fundnav);
                                     }
                                    else{
                                        detailFund.NAVDate = null;
                                    }
                                }catch(Exception e){
                                    system.debug('Error in NAV Date (Fund Detail): '+e.getMessage());
                                }
                                string fundtotal = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].FUNDTOTAL);
                                if(fundtotal != null && fundtotal.trim() != ''){
                                    detailFund.TotFundAmount = decimal.valueOf(double.valueOf(fundtotal));
                                }
                                else{
                                     detailFund.TotFundAmount = 0;
                                }
                                
                                //Premium Breakdown
                                string plan_type = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_TYPE);
                                string plan_code = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_CODE);
                                string plan_status = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_STATUS);
                                string plan_effectivedate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_EFFECTIVEDATE);
                                string plan_expireddate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_EXPIREDDATE);
                                string plan_terminationdate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_TERMINATIONDATE);
                                decimal plan_si = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].PLAN_SI);
                                decimal modal_plan_premium = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].MODAL_PLAN_PREMIUM);
                                decimal modal_plan_loading = bacaDecimal(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].MODAL_PLAN_LOADING);
                                
                                val6 = plan_type.trim() +'::'+plan_code.trim() +'::'+string.valueOf(modal_plan_premium).trim() +'::'+string.valueOf(plan_si).trim()+'::'+'::'
                                       +string.valueOf(modal_plan_loading).trim()+'::'+plan_effectivedate.trim()+'::'+plan_expireddate.trim()+'::'+plan_terminationdate.trim()+'::'
                                       +plan_status.trim();
                                
                                system.debug('Val6: ' +val6);
                                
                                if(temp6 != val6){
                                    PremiumBreakdown prembreak = new PremiumBreakdown();
                                    prembreak.PlanType = plan_type;
                                    prembreak.PlanCode = plan_code;
                                    prembreak.PlanStatus = plan_status;
                                    if(plan_si != null && plan_si != 0){
                                        prembreak.PlanSi = plan_si;
                                    }
                                    else{
                                        prembreak.PlanSi = 0;
                                    }
                                    if(modal_plan_premium != null){
                                        prembreak.ModalPlanPremium = modal_plan_premium;
                                    }
                                    else{
                                        prembreak.ModalPlanPremium = 0;
                                    }
                                    if(modal_plan_loading != null){
                                        prembreak.ModalPlanLoading = modal_plan_loading;
                                    }
                                    else{
                                         prembreak.ModalPlanLoading = 0;
                                    }
                                    try{
                                        if(plan_effectivedate.trim() != '' && plan_effectivedate.trim() != '0' && plan_effectivedate.trim() != '00000000'){
                                            prembreak.EffectiveDate = convertStringToDate(plan_effectivedate);
                                        }
                                        else{
                                            prembreak.EffectiveDate = null;
                                        }
                                        if(plan_expireddate.trim() != '' && plan_expireddate.trim() != '0' && plan_expireddate.trim() != '00000000'){
                                            prembreak.ExpiredDate = convertStringToDate(plan_expireddate);
                                        }
                                        else{
                                            prembreak.ExpiredDate = null;
                                        }
                                        if(plan_terminationdate.trim() != '' && plan_terminationdate.trim() != '0' && plan_terminationdate.trim() != '00000000'){
                                            prembreak.TerminationDate = convertStringToDate(plan_terminationdate);
                                        }
                                        else{
                                            prembreak.TerminationDate = null;
                                        }
                                    }catch(Exception e){
                                      system.debug('Error has occured in Premium Breakdown: '+e.getMessage());
                                    }
                                    premiumBreakdownList.add(prembreak);    
                                    temp6 = val6;
                                }
                                
                                //Policy Change
                                string transcode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].TRANSCODE);
                                string transdesc = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].TRANDESC);
                                string submitdate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].SUBMITDATE);
                                string createdate = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].CREATEDATE);
                                string status = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].STATUS);
                                string remarkdesc = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].REMARKDESC);
                                // new ALI
                                
                                string EventType = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].EventType);
                                string UserID = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].UserID);
                                string Source = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].Source);
                                
                                val7 = transcode.trim() +'::'+transdesc.trim()+'::'+submitdate.trim()+'::'+
                                       createdate.trim()+'::'+status.trim()+'::'+remarkdesc.trim();
                                
                                system.debug('Val7: ' +val7);
                                
                                if(temp7 != val7){
                                    PolicyChange pc = new PolicyChange();
                                    pc.TransactionCode = transcode;
                                    pc.TransactionDesc = transdesc;
                                    // new ALI
                                    pc.EventType = EventType;
                                    pc.UserID = UserID;
                                    pc.Source = Source;
                                    pc.Status = status;
                                    if(pc.Status == '0'){
                                        pc.Status = '';
                                    }
                                    pc.Remark = remarkdesc;
                                    if(pc.Remark == '0'){
                                        pc.Remark = '';
                                    }
                                    try{
                                        if(submitdate != null && submitdate.trim() != '' && submitdate.trim() != '0' && submitdate.trim() != '00000000'){
                                            pc.SubmitDate = convertStringToDate(submitdate);
                                        }
                                        else{
                                            pc.SubmitDate = null;
                                        }
                                        if(createdate != null && createdate.trim() != '' && createdate.trim() != '0' && createdate.trim() != '00000000'){
                                            pc.CreateDate = convertStringToDate(createdate);
                                        }
                                        else{
                                            pc.CreateDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in policy change date: '+e.getMessage());
                                    }
                                    policyChangeList.add(pc);    
                                    temp7 = val7;
                                }
                                
                                //Fund Transaction
                                string nuprc = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NUPRC);
                                string nfccy = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NFCCY);
                                string ncode = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NCODE);
                                string nsprd = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NSPRD);
                                string ntcod = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NTCOD);
                                string namtp = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NAMTP);
                                string namtu = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NAMTU);
                                string nptyp = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NPTYP);
                                string npmod = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NPMOD);
                                string nfprd = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NFPRD);
                                string nuprd = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NUPRD);
                                string ntdat = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NTDAT);
                                string neffd = bacaString(ambilNonRLSALI.PolicyDetailsNonRLSALI[i].NEFFD);
                                
                                val8 = neffd.trim() +'::'+ntdat.trim()+'::'+nptyp.trim()+'::'+ntcod.trim()+'::'+nfccy.trim()+'::'+
                                       nfprd.trim()+'::'+nuprd.trim()+'::'+ncode.trim()+'::'+nuprc.trim()+'::'+nsprd.trim()+'::'+
                                       namtp.trim()+'::'+namtu.trim()+'::'+npmod.trim();
                                
                                system.debug('Val8: ' +val8);
                                
                                if(temp8 != val8){
                                    FundTransaction fundtrx = new FundTransaction();
                                    fundtrx.FundCodes = ncode;
                                    if(nuprc != null && nuprc.trim() != ''){
                                        fundtrx.UnitPrice = decimal.valueOf(double.valueOf(nuprc));
                                    }
                                    else{
                                        fundtrx.UnitPrice = 0;
                                    }
                                    fundtrx.FundCurrency = nfccy;
                                    fundtrx.Spread = nsprd;
                                    fundtrx.TrxCode = ntcod;
                                    if(namtp != null && namtp.trim() != ''){
                                        fundtrx.TrxAmount = decimal.valueOf(double.valueOf(namtp));
                                    }
                                    else{
                                        fundtrx.TrxAmount = 0;
                                    }
                                    if(namtu != null && namtu.trim() != ''){
                                        fundtrx.TrxUnit = decimal.valueOf(double.valueOf(namtu));
                                    
                                    }
                                    else{
                                        fundtrx.TrxUnit = 0;
                                    }
                                    fundtrx.ProcessingType = nptyp; 
                                    fundtrx.ProcessingMode = npmod;
                                    try{
                                        if(nfprd.trim() != '' && nfprd.trim() != '0' && nfprd.trim() != '00000000'){
                                            fundtrx.FundPriceDate = convertStringToDate(nfprd);
                                        }
                                        else{
                                            fundtrx.FundPriceDate = null;
                                        }
                                        if(nuprd.trim() != '' && nuprd.trim() != '0' && nuprd.trim() != '00000000'){
                                            fundtrx.ValuationDate = convertStringToDate(nuprd);
                                        }
                                        else{
                                            fundtrx.ValuationDate = null;
                                        }
                                        if(ntdat.trim() != '' && ntdat.trim() != '0' && ntdat.trim() != '00000000'){
                                            fundtrx.TrxDate = convertStringToDate(ntdat);
                                        }
                                        else{
                                            fundtrx.TrxDate = null;
                                        }
                                        if(neffd.trim() != '' && neffd.trim() != '0' && neffd.trim() != '00000000'){
                                            fundtrx.TrxEffectiveDate = convertStringToDate(neffd);
                                        }
                                        else{
                                            fundtrx.TrxEffectiveDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in fund transaction date: '+e.getMessage());
                                    }
                                    fundTrxList.add(fundtrx);
                                    temp8 = val8;
                                }
                            }
                        }
                    }
                }
                catch(Exception e){
                    system.debug('Return from WSDL/DESRTN: ' +errorDSRTN);
                }
                Pelanggan.CountSFDC_CN = trxBackEndRHSList.size();
                Pelanggan.CountSFDC_PH = TrxPolicyHistoryList.size();
                Pelanggan.CountSFDC_Payment = trxPaymentList.size();                
                
                // delete BackEndPaging jika policy nya sama dan seluruh tanggal dibawah today.
                //Datetime HariINI = Datetime.Now()-1;
                //trxBEP = [SELECT id FROM BackEndPaging__c WHERE CreatedDate <: HariINI LIMIT 10000];
                //if (trxBEP.size() > 0) delete trxBEP;
                trxBEP = [SELECT id FROM BackEndPaging__c WHERE PolicyNo__c =: PolicyNo and Entity__c =: Entity and PolicyApp__c =: PolicyApp];
                if (trxBEP.size() > 0) delete trxBEP;
                trxBEP = new List<BackEndPaging__c>();
                if (trxBackEndRHSList.size() > 0) {
                    for (integer i = 0; i < trxBackEndRHSList.size(); i++) {
                        BackEndPaging__c backend = new BackEndPaging__c();
                        backend.PolicyNo__c = PolicyNo;
                        backend.Entity__c = Entity;
                        backend.PolicyApp__c = PolicyApp;
                        backend.RecordType__c = 'CallNote';
                        
                        backend.CallNote_SOURCE__c = trxBackEndRHSList[i].SOURCE;
                        backend.CallNote_NOTE__c = trxBackEndRHSList[i].NOTE; //backend.NOTE = backend_NOTE;
                        backend.CallNote_STATUS__c = trxBackEndRHSList[i].STATUS; //backend.STATUS = backend_STATUS;
                        backend.CallNote_CWC__c = trxBackEndRHSList[i].CWC; //backend.CWC = backend_CWC;
                        backend.CallNote_CREATEBY__c = trxBackEndRHSList[i].CREATEBY; //backend.CREATEBY = backend_CREATEBY;
                        backend.CallNote_RETURNCODE__c = trxBackEndRHSList[i].RETURNCODE; //backend.RETURNCODE = backend_RETURNCODE;
                        backend.CallNote_CREATEDATE2__c = trxBackEndRHSList[i].CREATEDATE2; //backend.CREATEDATE2 = backend_CREATEDATE;
                        backend.callNote_CREATEDATE__c = trxBackEndRHSList[i].CREATEDATE;
                        trxBEP.add(backend);
                    }
                }
                if (trxPaymentList.size() > 0) {
                    for (integer i = 0; i < trxPaymentList.size(); i++) {
                        BackEndPaging__c backend = new BackEndPaging__c();
                        backend.PolicyNo__c = PolicyNo;
                        backend.Entity__c = Entity;
                        backend.PolicyApp__c = PolicyApp;
                        backend.RecordType__c = 'Payment';

                        backend.Payment_TransactionType__c = trxPaymentList[i].TransactionType;
                        backend.Payment_SubmissionDate__c = trxPaymentList[i].SubmissionDate;
                        backend.Payment_PaymentDate__c = trxPaymentList[i].PaymentDate;
                        backend.Payment_DueDate__c = trxPaymentList[i].DueDate;
                        backend.Payment_Amount__c = trxPaymentList[i].Amount;
        
        // new ALI
                        backend.Payment_Type__c = trxPaymentList[i].Type;
                        backend.Payment_REFFERENCENO__c = trxPaymentList[i].REFFERENCENO;
                        backend.Payment_ACCOUNTNO__c = trxPaymentList[i].ACCOUNTNO;
                        backend.Payment_CARDNO__c = trxPaymentList[i].CARDNO;
                        backend.Payment_ACCOUNTNAME__c = trxPaymentList[i].ACCOUNTNAME;
                        backend.Payment_CARDNAME__c = trxPaymentList[i].CARDNAME;
                        backend.Payment_BANK__c = trxPaymentList[i].BANK;
                        backend.Payment_CARDEXPIRE__c = trxPaymentList[i].CARDEXPIRE;
                        backend.Payment_Status__c = trxPaymentList[i].Status;

                        backend.Payment_BILLINGNO__c = trxPaymentList[i].BILLINGNO;
                        backend.Payment_Payment_DATE__c = trxPaymentList[i].Payment_DATE;
                        backend.Payment_AGE__c = trxPaymentList[i].AGE;
                        backend.Payment_MONTHSBILLED__c = trxPaymentList[i].MONTHSBILLED;
                        backend.Payment_POLICYNO__c = trxPaymentList[i].POLICYNO;
                        backend.Payment_PRODUCT__c = trxPaymentList[i].PRODUCT;
                        backend.Payment_AUTHCODE__c = trxPaymentList[i].AUTHCODE;
                        backend.Payment_REMARK__c = trxPaymentList[i].REMARK;
                        backend.PAYMENT_COUNT_PAID__c = trxPaymentList[i].COUNT_PAID;
                        backend.PAYMENT_COUNT_NOT_PAID__c = trxPaymentList[i].COUNT_NOT_PAID;
                        
                        trxBEP.add(backend);
                    }
                }
                if (TrxPolicyHistoryList.size() > 0) {
                    for (integer i = 0; i < TrxPolicyHistoryList.size(); i++) {
                        BackEndPaging__c backend = new BackEndPaging__c();
                        backend.PolicyNo__c = PolicyNo;
                        backend.Entity__c = Entity;
                        backend.PolicyApp__c = PolicyApp;
                        backend.RecordType__c = 'PolicyHistory';

                        backend.PolicyHistory_UserID__c = TrxPolicyHistoryList[i].UserID;
                        backend.PolicyHistory_EventDate__c = TrxPolicyHistoryList[i].EventDate;
                        backend.PolicyHistory_EventType__c = TrxPolicyHistoryList[i].EventType;
                        backend.PolicyHistory_Description__c = TrxPolicyHistoryList[i].Description;
                        backend.PolicyHistory_PolicyStatus__c = TrxPolicyHistoryList[i].PolicyStatus;
                        backend.PolicyHistory_Remark__c = TrxPolicyHistoryList[i].Remark;

                        trxBEP.add(backend);
                    }                    
                }
                if (trxClaimList.size() > 0) {
                    for (integer i = 0; i < trxClaimList.size(); i++) {
                        BackEndPaging__c backend = new BackEndPaging__c();
                        backend.PolicyNo__c = PolicyNo;
                        backend.Entity__c = Entity;
                        backend.PolicyApp__c = PolicyApp;
                        backend.RecordType__c = 'Claim';

                        backend.Claim_ProductType__c = trxClaimList[i].ProductType;
                        backend.Claim_ClaimNumber__c = trxClaimList[i].ClaimNumber;
                        backend.Claim_ClaimType__c = trxClaimList[i].ClaimType;
                        backend.Claim_ClaimPlan__c = trxClaimList[i].ClaimPlan;
                        backend.Claim_SubmissionDate__c = trxClaimList[i].SubmissionDate;
                        backend.Claim_ApprovalDate__c = trxClaimList[i].ApprovalDate;
                        backend.Claim_Amount__c = trxClaimList[i].Amount;
                        backend.Claim_ClaimCurrency__c = trxClaimList[i].ClaimCurrency;
                        backend.Claim_ClaimStatus1__c = trxClaimList[i].ClaimStatus1;
                        backend.Claim_ClaimStatus2__c = trxClaimList[i].ClaimStatus2;
                        backend.Claim_StatusDesc__c = trxClaimList[i].StatusDesc;
                        backend.Claim_MODIFYDATE__c = trxClaimList[i].MODIFYDATE;
                        backend.Claim_CLAIMANT__c = trxClaimList[i].CLAIMANT;
                        backend.Claim_HOSPITAL__c = trxClaimList[i].HOSPITAL;
                        backend.Claim_ADMISSIONDATE__c = trxClaimList[i].ADMISSIONDATE;
                        backend.Claim_REGULARDAYS__c = trxClaimList[i].REGULARDAYS;
                        backend.Claim_ICUDAYS__c = trxClaimList[i].ICUDAYS;
                        backend.Claim_ISEXGRATIACASE__c = trxClaimList[i].ISEXGRATIACASE;
                        backend.Claim_REMARK__c = trxClaimList[i].REMARK;
                        backend.Claim_DECISIONDATE__c = trxClaimList[i].DECISIONDATE;
                        backend.Claim_PAYMENTDATE__c = trxClaimList[i].PAYMENTDATE;
                        backend.Claim_ACCOUNTNO__c = trxClaimList[i].ACCOUNTNO;
                        backend.Claim_ACCOUNTNAME__c = trxClaimList[i].ACCOUNTNAME;
                        backend.Claim_BANKNAME__c = trxClaimList[i].BANKNAME;
                        
                        trxBEP.add(backend);
                    }
                }
                
                if (trxBEP.size() > 0) insert trxBEP;
                                // new ALI
                                //*
                                //RHS List
                                string temp_CaseNumber;
                                string temp_Type;
                                string temp_Subject;
                                date temp_Datetimeopened;
                                string temp_Status;
                                string temp_Owner;
        
                                list<case> listcs;
                                if (Test.isRunningTest())
                                    listcs = [SELECT id, CaseNumber, Type, Case_Type__c, Nature__c, Category__c, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Type != '' Order by CreatedDate desc LIMIT 1];
                                else
                                    listcs = [SELECT id, CaseNumber, Type, Case_Type__c, Nature__c, Category__c, Subject, CreatedDate, Status, Owner.Name FROM Case WHERE Contactid =:contactId Order by CreatedDate desc];
                                for (case cs : listcs){
                                    if (cs.type == 'Inquiry' || Test.isRunningTest()) {
                                        TrxInquiry temp = new TrxInquiry();
                                        temp.CaseNumber = cs.CaseNumber;
                                        temp.Type = cs.Case_Type__c;
                                        temp.Subject = cs.Subject;
                                        temp.Datetimeopened = date.valueof(cs.CreatedDate);
                                        temp.Status = cs.Status;
                                        temp.Owner = cs.Owner.Name;
                                        TrxInquiryList.add(temp);
                                        if (cs.Status != 'Closed')
                                            trxOpenLastInquiryList.add(temp);
                                    }
                                    else if (cs.type == 'Request' || Test.isRunningTest()) {
                                        TrxRHS temp = new TrxRHS();
                                        temp.CaseNumber = cs.CaseNumber;
                                        temp.Type = cs.Case_Type__c;
                                        temp.Subject = cs.Subject;
                                        temp.Datetimeopened = date.valueof(cs.CreatedDate);
                                        temp.Status = cs.Status;
                                        temp.Owner = cs.Owner.Name;
                                        trxRHSList.add(temp);
                                        if (cs.Status != 'Closed')
                                            trxOpenLastRHSList.add(temp);                                        
                                    }
                                    else if (cs.type == 'Complaint' || Test.isRunningTest()) {
                                        TrxCHS temp = new TrxCHS();
                                        temp.CaseNumber = cs.CaseNumber;
                                        temp.Type = cs.Case_Type__c;
                                        temp.Subject = cs.Subject;
                                        temp.Datetimeopened = date.valueof(cs.CreatedDate);
                                        temp.Status = cs.Status;
                                        temp.Owner = cs.Owner.Name;
                                        trxCHSList.add(temp);
                                        if (cs.Status != 'Closed')
                                            trxOpenLastCHSList.add(temp);
                                    }
                                }


            }
            else{
                ApexPages.Message errEmail = new ApexPages.Message(ApexPages.Severity.ERROR,'Page cannot be displayed due to invalid policyApp / policyApp not found'); 
                ApexPages.addMessage(errEmail);
                isDisplayed = false;
                displayGIOnly = false;
            }
            //begin:added by WK, 20150422 to log process
            applogScreen.Policy_App__c = contactRec.PolicyApp__c; 
            applogScreen.entity__c = contactRec.Entity__c;
            applogScreen.Policy_No__c = contactRec.Policy_No_ALI__c;

            applogWS.Policy_App__c = contactRec.PolicyApp__c; 
            applogWS.entity__c = contactRec.Entity__c;
            applogWS.Policy_No__c = contactRec.Policy_No_ALI__c;
            //applogScreen.end_date__c = system.now();
            applogScreen.EndLongTime__c = system.now().getTime();

            //if(test.isRunningTest()) applogws.StartLongTime__c = system.now().getTime();
            //if(test.isRunningTest()) applogScreen.StartLongTime__c = system.now().getTime();
            logList.add(applogws);
            logList.add(applogScreen);
            
            if(test.isRunningTest()) {
                for (integer i = 0; i < logList.size(); i++) {
                    logList[i].StartLongTime__c = system.now().getTime();
                    logList[i].EndLongTime__c = system.now().getTime();
                }
            }
            insert logList;
            //end:added by WK, 20150422 to log process
            
            //----------------The following codes are used to update the contact data from WS into SFDC -----------------------------
            if(contactRec.Policy_Status__c != polisRider.PolicyStatus){
                contactRec.Policy_Status__c = polisRider.PolicyStatus;
            }
            if(tipe == 'RLS' || tipe == 'Non RLS 1' || tipe == 'Non RLS 2' || tipe == 'Non RLS 3'){
                if(contactRec.Policy_Effective_Date__c != polisRider.EffectiveDate){
                    contactRec.Policy_Effective_Date__c = polisRider.EffectiveDate;
                }
                if(contactRec.Agent_Name__c != agen.AgentName){
                    contactRec.Agent_Name__c = agen.AgentName;
                }
                if(contactRec.Agent_Code__c != agen.AgentNo){
                    contactRec.Agent_Code__c = agen.AgentNo;
                }
                if(contactRec.Agent_Status__c != agen.Status){
                    contactRec.Agent_Status__c = agen.Status;
                }
                if(contactRec.Premium__c != polisRider.TotalPremium){
                    contactRec.Premium__c = polisRider.TotalPremium;
                }
            } 
            if(tipe == 'GI'){
                if(contactRec.Policy_Effective_Date__c != polisRider.PolicyDate){
                    contactRec.Policy_Effective_Date__c = polisRider.PolicyDate;
                }
                if(contactRec.Premium__c != polisRider.PremiumGI){
                    contactRec.Premium__c = polisRider.PremiumGI;
                }
                if(contactRec.Segment_Name__c != polisRider.Segment){
                    contactRec.Segment_Name__c = polisRider.Segment;
                }
                if(contactRec.Branch_Name__c != polisRider.Branch){
                    contactRec.Branch_Name__c = polisRider.Branch;
                }
                if(contactRec.Branch_Code__c != polisRider.BranchCode){
                    contactRec.Branch_Code__c = polisRider.BranchCode;
                }                
                if(giClaimList.size() > 0){
                    integer panjangList = giClaimList.size();
                    if(contactRec.Date_of_Accident__c != giClaimList[panjangList-1].DateofLoss){
                        contactRec.Date_of_Accident__c = giClaimList[panjangList-1].DateofLoss;
                    }
                    if(contactRec.Driver__c != giClaimList[panjangList-1].DriverName){
                        contactRec.Driver__c = giClaimList[panjangList-1].DriverName;
                    }
                    if(contactRec.Accident_Place__c != giClaimList[panjangList-1].AccidentPlace){
                        contactRec.Accident_Place__c = giClaimList[panjangList-1].AccidentPlace;
                    }
                    if(contactRec.Detail_of_Damage__c != giClaimList[panjangList-1].Description){
                        contactRec.Detail_of_Damage__c = giClaimList[panjangList-1].Description;
                    }
                }
                if(TOCList.size() > 0){
                    if(TOCList[0].tableLabel4 == 'Year of Manufacturing'){
                    contactRec.Production_Year__c = TOCList[0].tableValue4;
                    }
                    if(TOCList[0].tableLabel5 == 'License Number'){
                        contactRec.Licence_Number__c = TOCList[0].tableValue5;
                    }
                    if(TOCList[0].tableLabel6 == 'Machine Number'){
                        contactRec.Machine_No__c = TOCList[0].tableValue6;
                    }
                    if(TOCList[0].tableLabel7 == 'Chasis Number'){
                        contactRec.Chassis_no__c = TOCList[0].tableValue7;
                    }
                    if(TOCList[0].tableLabel1 == 'Vehicle Brand'){
                        contactRec.Vehicle_Type__c = TOCList[0].tableValue1;
                    }
                    if(TOCList[0].tableLabel11 == 'Colour'){
                        contactRec.Color__c = TOCList[0].tableValue11;
                    }
                    if(TOCList[0].tableLabel14 == 'Vehicle Cubic Capacity'){
                        contactRec.Machine_Capacity__c = TOCList[0].tableValue14;
                    }
                }
            }
            update contactRec;
        }
    }
    
    private static Date convertStringToDate(string dateStr){
        system.debug('Input date: ' +dateStr);
        
        string newDate = dateStr.replaceAll('/', '').replaceAll('-', '').replaceAll('\\.', '');
        system.debug('New date: '+newDate);
        Integer year = Integer.valueOf(newDate.substring(0,4));
        Integer month = Integer.valueOf(newDate.substring(4,6));
        Integer day = Integer.valueOf(newDate.substring(6,8));
        Date dateObj = Date.valueOf(year+'-'+month+'-'+day);
        system.debug('DateObj: ' +dateObj);
        return date.newInstance(year, month, day);
    }
}