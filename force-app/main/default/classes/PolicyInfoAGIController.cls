global with sharing class PolicyInfoAGIController {
    public date StartDate {get; set;}
    public date EndDate {get; set;}
    public String ProductCode {get; set;}
    /** ATTRIBUTES 
    **/ 
    public Boolean flagClaim {get; set;} // Added by Suryono 8/8/2019
    
    public string sessionId {get; set;}
     
    // Attributes Based on End To End
    public CustomerInfo customerInfoData {get;set;} public String customerInfoDataReqPayloadJSON {get;set;} public String customerInfoDataResPayloadJSON {get;set;}
    
    //public AccountInfo accountInfoData {get;set;}
    public PolicyDetailLife policyDetailLifeData {get;set;} //public String policyDetailLifeJSON {get;set;}
    public PolicyDetailGI policyDetailGIData {get;set;}  
     
    public AgentInfo agentInfoData {get;set;} 
    public List <AgentHierarchy> agentReportingStructureHierarchyList {get;set;} public String agentReportingStructureHierarchyListReqPayloadJSON {get;set;} 
    public List <AgentHierarchy> agentTopDownHierarchyList {get;set;} public String agentTopDownHierarchyListReqPayloadJSON {get;set;} public String agentTopDownHierarchyListResPayloadJSON {get;set;}
    
    public List <PolicyDetailGI> policyDetailList {get;set;}
    public List <InsuredDetail> insuredDetailList {get;set;}
    public List <InsuredDetailLife> insuredDetailLifeList {get;set;} 
    public List <InsuredDetailGIMV> insuredDetailGIMVList {get;set;} 
    public List <InsuredDetailGINonMV> insuredDetailGINonMVList {get;set;} 
    public List <BeneficiaryDetail> beneficiaryDetailList {get;set;} 
    public List <PremiumBreakdown> premiumBreakdownList {get;set;} 
    public List <BenefitDetail> benefitDetailList {get;set;} 
    public List <PolicyChangeLife> policyChangeLifeList {get;set;} 
    public List <EndorsementGI> endorsementGIList {get;set;} 
    public List <RiskInfo> riskInfoList {get;set;} 
    public List <RiskDetail> riskDetailList {get;set;} 
    public OwnRisk ownRiskData {get;set;} 
    public string ownRiskDataJSON {get;set;}
    public List <InterestInfo> interestInfoList {get;set;} public String interestInfoListJSON {get;set;} 
    
    public List <PaymentHistoryLife> paymentHistoryLifeList {get;set;}  
    public integer paymentHistoryLifeLastPageNo {get;set;} 
    public integer paymentHistoryLifeRowPerPage {get;set;} 
    
    public List <PaymentHistoryGI> paymentHistoryGIList {get;set;}
     
    public List <FundHistory> fundHistoryList {get;set;} 
    public integer fundHistoryLastPageNo {get;set;} 
    public integer fundHistoryRowPerPage {get;set;}
    public String fundHistoryLastDate {get;set;}
    
    public List <FundDetail> fundDetailList {get;set;} 
    public integer fundDetailLastPageNo {get;set;} 
    public integer fundDetailRowPerPage {get;set;} 
    
    public List <FundPriceHistory> fundPriceHistoryList{get;set;} 
    public integer fundPriceHistoryLastPageNo {get;set;} 
    public integer fundPriceHistoryRowPerPage {get;set;} 
    
    public List <ClaimDetailLife>  claimDetailLifeList {get;set;} 
    public integer claimDetailLifeLastPageNo {get;set;} 
    public integer claimDetailLifeRowPerPage {get;set;} 
    
    public List <ClaimDetailGI> claimDetailGIList  {get;set;} 
    public List <ClaimDetailGI> claimDetailGIList2  {get;set;} 
    public integer claimDetailGILastPageNo {get;set;} 
    public integer claimDetailGIRowPerPage {get;set;} 
    
    
    public String assessmentNotesDetailTitle {get;set;}
    public List <AssessmentNotesDetail> assessmentNotesDetailList {get;set;} 
    public String assessmentNotesDetailJSON {get;set;} 
    public integer assessmentNotesDetailLastPageNo {get;set;} 
    
    public List <AssessmentNotesSummary> assessmentNotesSummaryUWList {get;set;} 
    public List <AssessmentNotesDetail> assessmentNotesDetailUWList {get;set;} 
    public String assessmentNotesSummaryUWJSON {get;set;}
    public integer assessmentNotesSummaryUWLastPageNo {get;set;}
    public integer assessmentNotesSummaryUWRowPerPage {get;set;}
    
    public List <AssessmentNotesSummary> assessmentNotesSummaryPOSList {get;set;} 
    public List <AssessmentNotesDetail> assessmentNotesDetailPOSList {get;set;} 
    public String assessmentNotesSummaryPOSJSON {get;set;}
    public integer assessmentNotesSummaryPOSLastPageNo {get;set;}
    public integer assessmentNotesSummaryPOSRowPerPage {get;set;}
    
    public List <AssessmentNotesSummary> assessmentNotesSummaryPAList {get;set;} 
    public List <AssessmentNotesDetail> assessmentNotesDetailPAList {get;set;} 
    public String assessmentNotesSummaryPAJSON {get;set;}
    public integer assessmentNotesSummaryPALastPageNo {get;set;}
    public integer assessmentNotesSummaryPARowPerPage {get;set;}
    
    public List <AssessmentNotesSummary> assessmentNotesSummaryCLMList {get;set;} 
    public List <AssessmentNotesDetail> assessmentNotesDetailCLMList {get;set;}
    public String assessmentNotesSummaryCLMJSON {get;set;}
    public integer assessmentNotesSummaryCLMLastPageNo {get;set;}
    public integer assessmentNotesSummaryCLMRowPerPage {get;set;}
    
    public List <AssessmentNotesSummary> assessmentNotesSummaryOTHList {get;set;} 
    public List <AssessmentNotesDetail> assessmentNotesDetailOTHList {get;set;} 
    public String assessmentNotesSummaryOTHJSON {get;set;}
    public integer assessmentNotesSummaryOTHLastPageNo {get;set;}
    public integer assessmentNotesSummaryOTHRowPerPage {get;set;}
    

    public List<CashValueDetail> cashValueDetailList {get;set;}
    
    /* RHS, CHS, Inquiry ... */
    public List <Case> RHSList {get;set;}
    public List <Case> CHSList {get;set;}
    public List <Case> InquiryList {get;set;}
    
    // notes: previous attributes 
    public String contactId {get;set;}
    public string policyNo {get; set;}
    public string entity {get; set;}
    public string policyApp {get; set;}
    public string token {get; set;}
    
    public string agentServicingCode  {get; set;}
    public string agentProducingCode  {get; set;}
    
    
    public string contactName {get; set;}
    public string certificateNo {get; set;}
    public string agentNo {get; set;}
   
    
    //public CustomerInfo pelanggan {get;set;}
    public Agent agen {get;set;}
    public PolicyRider polisRider {get;set;}
    public List<Insured> insuredList {get;set;}
    public List<Beneficiary> beneficiaryList {get;set;}
    //public List<BeneficiaryDetail> beneficiaryDetailList {get;set;}
    public List<Benefit> benefitList {get;set;}    
    
    public List<TrxPayment> trxPaymentList {get;set;}
    public List<TrxClaim> trxClaimList {get;set;}
    public List<GIClaim> giClaimList {get;set;}
    public List<GIEndorsement> giEndorsementList {get;set;} 
    public List<DetailFund> detailFundList {get;set;}
    public List<FundTransaction> fundTrxList {get;set;}
    
    public List<PremiumBreakdown> premiumBreakdownList2 {get;set;}
    public List<PolicyChange> policyChangeList {get;set;}
    public List<TableofContent> TOCList {get;set;}
    public List<AccountDetail> accountDetailList {get;set;}
    public List<PremiumDetail> premiumDetailList {get;set;}
    // public List<InterestInfo> interestInfoList {get;set;}
    public DetailFund detailFund {get;set;}
    //public List<CashValueDetail> cashValueList {get;set;}
    //public boolean isDisplayed {get;set;}
    //public boolean displayRLSOnly {get;set;}
    //public boolean displayGIOnly {get;set;}
 
    
    
    // ============================================================================
    // New Attributes : by doddy
    public boolean isDisplayAFI {get;set;}
    public boolean isDisplayAMFS {get;set;}
    public boolean isDisplayMAGI {get;set;}
    public boolean isDisplayAGI {get;set;}
    
    public boolean isDisplayAFI_AMFS {get;set;}
    public boolean isDisplayAMFS_MAGI {get;set;}
    public boolean isDisplayAFI_MAGI {get;set;}
    public boolean isDisplayAFI_AGI {get;set;}
    public boolean isDisplayAMFS_AGI {get;set;}
    public boolean isDisplayMAGI_AGI {get;set;}
    
    public boolean isDisplayAFI_AMFS_MAGI {get;set;}
    public boolean isDisplayAFI_AMFS_AGI {get;set;}
    public boolean isDisplayAFI_AGI_MAGI {get;set;}
    public boolean isDisplayAGI_AMFS_MAGI {get;set;}
    
    public boolean isDisplayAFI_AMFS_MAGI_AGI {get;set;}
    
    public boolean isDisplayInsuredMV {get;set;}
    public boolean isDisplayInsuredNonMV {get;set;}
    
    public boolean isCustomerProfile {get;set;}
    public boolean isAgentProfile {get;set;}
    
    public boolean isDisplayJSON {get;set;}
    
    
    
    
    //public assNotesJSON assNotesSummary  {get;set;}
    //public AssNotesJSON assNotesTemp  {get;set;}
    //public AssNotesJSON assNotesPOS  {get;set;}
    //public AssNotesJSON assNotesSummaryJSON {get; set;}
    
    //public AssNotesDetailJSON assNotesDetailPOS  {get;set;} 
    public AssNotesDetailJSON assNotesDetail {get;set;} 

    
    public static AssNotesDetailJSON assNotesDetailJSONTEST  {get;set;} 
    
    
    //*** Data Transfer Object ***// 
    
    public class CustomerInfo {
        public string policyOwnerID {get; set;}
        public string gender {get; set;}
        public Date dateOfBirth {get; set;}
        public string age {get; set;}
        public string placeOfBirth {get; set;}
        public string address1 {get; set;}
        public string address2 {get; set;}
        public string address3 {get; set;}
        public string address4 {get; set;}
        public string agentServicingCode {get; set;}
        public string agentProducingCode {get; set;}
        
        public CustomerInfo () {
        }
    }
    
    public class AccountInfo {
        public string No      {get; set;}
        public string Name {get; set;}
        public string FirstName {get; set;}
        public string MiddleName {get; set;}
        public string LastName {get; set;}
        public string Salutation {get; set;}
        public string Title {get; set;}
        public string InsuredName {get; set;}
        public string CustomerID {get; set;}
        public string CustomerPolicyNo {get; set;}
        public string Phone1 {get; set;}
        public string Phone2 {get; set;}
        public string Mobile1 {get; set;}
        public string Mobile2 {get; set;}
        public string Email1 {get; set;}
        public string Email2 {get; set;}
        public string Fax1 {get; set;}
        public string Fax2 {get; set;}
        public string ZipCode {get; set;}
        public string City {get; set;}
        public string InputerID {get; set;}
        public string Address1 {get; set;}
        public string Address2 {get; set;}
        public string Address3 {get; set;}
        public string Contact {get; set;}
        public string ContactAddress {get; set;}
        public string ContactPhone {get; set;}
        public string Curr {get; set;}
        public string MarketingOfficerName {get; set;}
        public string MarketingOfficerCode {get; set;}
        public string MarketingOfficerDept {get; set;}
        public string TransactionTypeDescription {get; set;}
        public string IntermediaryTypeDescription {get; set;}
        public string CustomerTypeDescription {get; set;}
        public string RelatedPolicy {get; set;}
        public string Description {get; set;}
        public string Gender {get; set;}
        public string Married {get; set;}
        public string Country {get; set;}
        public string IDPassportNumber {get; set;}
        public string Nationality {get; set;}
        public string Occupation {get; set;}
        public string Language {get; set;}
        public string Birthdate {get; set;}
        public string Age {get; set;}
        public string Birthplace {get; set;}
        public string VIP {get; set;}
        public string AlternateAddress {get; set;}

        public AccountInfo(){
        }

    }

    /* PolicyDetail
     * base on End to End Document
     * by Doddy 2016
     */
    public class PolicyDetailLife{ 
        
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
        //public string issueDateString {get;set;}
        
        public PolicyDetailLife(){
        }
    }

    public class PolicyDetailGI{
        public string No      {get; set;}
        public string Name {get; set;}
        public string FirstName {get; set;}
        public string MiddleName {get; set;}
        public string LastName {get; set;}
        public string Salutation {get; set;}
        public string Title {get; set;}
        public string InsuredName {get; set;}
        public string CustomerID {get; set;}
        public string CustomerPolicyNo {get; set;}
        public string Phone1 {get; set;}
        public string Phone2 {get; set;}
        public string Mobile1 {get; set;}
        public string Mobile2 {get; set;}
        public string Email1 {get; set;}
        public string Email2 {get; set;}
        public string Fax1 {get; set;}
        public string Fax2 {get; set;}
        public string ZipCode {get; set;}
        public string City {get; set;}
        public string InputerID {get; set;}
        public string Address1 {get; set;}
        public string Address2 {get; set;}
        public string Address3 {get; set;}
        public string Contact {get; set;}
        public string ContactAddress {get; set;}
        public string ContactPhone {get; set;}
        public string Curr {get; set;}
        public string MarketingOfficerName {get; set;}
        public string MarketingOfficerCode {get; set;}
        public string MarketingOfficerDept {get; set;}
        public string TransactionTypeDescription {get; set;}
        public string IntermediaryTypeDescription {get; set;}
        public string CustomerTypeDescription {get; set;}
        public string RelatedPolicy {get; set;}
        public string Description {get; set;}
        public string Gender {get; set;}
        public string Married {get; set;}
        public string Country {get; set;}
        public string IDPassportNumber {get; set;}
        public string Nationality {get; set;}
        public string Occupation {get; set;}
        public string Language {get; set;}
        public Date Birthdate {get; set;}
        public string Age {get; set;}
        public string Birthplace {get; set;}
        public string VIP {get; set;}
        public string AlternateAddress {get; set;}
        
        //---
        public string PolicyNo {get; set;}
        public string PolicyHolder {get; set;}
        public string ReferenceNo {get; set;}
        public string Insured {get; set;}
        //public string Description {get; set;}
        public Date StartDate {get; set;}
        public Date EndDate {get; set;}
        public string Premium {get; set;}
        public Date PolicyDate {get; set;}
        public Date ReferenceDate {get; set;}
        public Date CoverDate {get; set;}
        public string Segment {get; set;}
        public string BranchName {get; set;}
        public string BranchCode {get; set;}
        public string StatusDescription {get; set;}
        public string TSI {get; set;}
        public string CertificateNo {get; set;}
        public string Usage {get; set;}
        
        public PolicyDetailGI(){
        }
    }
    
     /* AgentInfo
     * base on End to End Document
     * by Doddy 2016
     */
    public class AgentInfo{
        public string AgentName {get; set;}
        public string AgentID {get; set;}
        public string AgentNo {get; set;}
        public string Entity {get; set;}
        public string Email {get; set;}
        public string Status {get; set;}
        public string Area {get; set;}
        public string DistributionCode {get; set;}
        public string DistributionType {get; set;}
        public string Mobile {get; set;}
        public Date JoinDate {get; set;}
        public string Address1 {get; set;}
        public string Address2 {get; set;}
        public string Address3 {get; set;}
        public string Address4 {get; set;}
        public string Leader1 {get; set;}
        public string Leader2 {get; set;}
        public string Leader3 {get; set;}
        public string Leader4 {get; set;}
        public string HomePhone1 {get; set;}
        public string HomePhone2 {get; set;}
        public string OfficePhone {get; set;} 
        public string OfficeAddress1 {get; set;}
        public string OfficeAddress2 {get; set;}
        public string OfficeAddress3 {get; set;}
        public string OfficeAddress4 {get; set;}
        
        public AgentInfo(){
            
        }
    }

    /* Agent Heirarchy
     * base on End to End Document
     * by Doddy 2016
     */
    public class AgentHierarchy{
        public string AgentCode {get; set;}
        public string AgentName {get; set;}
        public string PosCode {get; set;}
        public Date LeaderEffDate {get; set;}
        public string Term {get; set;}   
        
        public AgentHierarchy(){
            
        }   
    } 
     
    /* InsuredDetail
     * base on End to End Document
     * by Doddy 2016
     */
    public class InsuredDetail{
        public string Product {get; set;}
        public string IDNo {get; set;}
        public string Name {get; set;}
        public string PlaceofBirth {get; set;}
        public Date DateofBirth {get; set;}
        public string Gender {get; set;}
        public string Email {get; set;}
        public string Mobile {get; set;}
        public string VehicleMerkModel {get; set;}
        public string PoliceRegNo {get; set;} 
        public string YearofManufacturing {get; set;}
        public string PolicyCover {get; set;}
        public decimal SumInsured {get; set;}
        public decimal PremiumAmount {get; set;}
        public decimal ExtraCoverageLimits {get; set;}
        public string Deductible {get; set;}
        public string RiskOccupation {get; set;}
        public string ContractWorks {get; set;}
        public string Destination {get; set;}
        public string ObjectInsured {get; set;}
        public string VesselFlag {get; set;}
        public string NoEmployee {get; set;}
        public decimal TPLLimit {get; set;}
        public decimal LimitOccurrence {get; set;}
        public decimal LimitPeriod {get; set;}
        public string TerritorialLimit {get; set;}
        public string OwnerBusiness {get; set;}
        public string InsuredName {get; set;}
        public string Age {get; set;}
        public string Beneficiary {get; set;}
        public string Relation {get; set;}
        public string PolicyPlan {get; set;}
        public decimal Premium {get; set;}
        public string VesselName {get; set;}
        public string VesselType {get; set;}
        public string ConveyanceName {get; set;}
        public string DepartureFrom  {get; set;}
        public string To {get; set;}
        public date TimeDeparture {get; set;}
        public string TypeCover {get; set;}
        public decimal LimitAccident {get; set;}
        public string EstimateCarrying {get; set;}
        public string RatePremises {get; set;}
        public string RateTransit {get; set;}
        public string ContractTitle {get; set;}
        public string RatePremium {get; set;}
        
        public InsuredDetail(){
            
        }
    }
    
    public class InsuredDetailLife{ 
        public string IDNo {get; set;}
        public string Name {get; set;}
        public string PlaceofBirth {get; set;}
        public Date DateofBirth {get; set;}
        public string Gender {get; set;}
        public string Email {get; set;}
        public string Mobile {get; set;}
        public string Depno {get; set;}

        public InsuredDetailLife(){
        }
    }    
    
    public class InsuredDetailGIMV { 
        public string TableNo {get; set;}
        public string VehicleBrand {get; set;}
        public string Model {get; set;}
        public string SubModel {get; set;}
        public string YearofManufacturing {get; set;}
        public string LicenseNumber {get; set;}
        public string MachineNumber {get; set;}
        public string ChasisNumber {get; set;}
        public string Type {get; set;}
        public string Function {get; set;}
        public string Colour {get; set;}
        public string STNK {get; set;}
        public string Location {get; set;}

        public InsuredDetailGIMV(){
        }
    } 

    public class InsuredDetailGINonMV { 
        public string ConstructionClass {get; set;}
        public string RiskOccupation {get; set;}
        public string RiskCategory {get; set;}
        public string RiskLocation {get; set;}
        public string Lighting {get; set;}

        public InsuredDetailGINonMV(){
        }
    }     
    
      
    /* Beneficiary Detail
     * base on End to End Document
     * by Doddy 2016
     */
    public class BeneficiaryDetail{
        public string Name    {get; set;}
        public string PlaceofBirth  {get; set;}
        public date  DateOfBirth {get; set;}
        public string Gender  {get; set;}
        public string Relation   {get; set;}
        public string Percentage {get; set;}            
        
        public BeneficiaryDetail(){
        }       
    } 
    
    /* Benefit Detail
     * base on End to End Document
     * by Taufik 2019
     */
    public class BenefitDetail{
        public string PlanCode    {get; set;}
        public string BenefitCode  {get; set;}
        public string BenefitDesc  {get; set;}
        public decimal BenefitInDay  {get; set;}
        public decimal BenefitInVisit  {get; set;}
        public decimal BenefitInMonth  {get; set;}
        public decimal BenefitInYear  {get; set;}
        public decimal BenefitInLife  {get; set;}
        
        public BenefitDetail(){
        }       
    } 

    /* Premium Breakdown
     * base on End to End Document
     * by Doddy 2016
     */
    public class PremiumBreakdown{
        public string InsuranceProductCd {get;set;}
        public string PlanCode {get; set;}
        public string PlanType {get; set;}
        public Date PlanEffectiveDate {get; set;}
        public Date PlanExpiredDate {get; set;}
        public decimal PlanSI {get; set;}
        public decimal ModalPlanPremium {get; set;}
        public string PlanStatus {get; set;}
        public string ClassCode {get; set;}
        public decimal ModalPlanLoading {get; set;}
        public Date EffectiveDate {get; set;}
        public Date ExpiredDate {get; set;}
        public Date TerminationDate {get; set;}     
        public string TransactionNo {get; set;}
        public string ProductType {get; set;}
        public decimal GrossPremium {get; set;}
        public decimal NettPremium {get; set;}
        public string RiskNo {get; set;}
        public string InsuredNo {get; set;}
        public string InsuredName {get; set;}
        public decimal Total {get; set;}
        
        public PremiumBreakdown(){
        }       
    } 
    

    /* Policy Change
     * base on End to End Document
     * by Doddy 2016
     */
    public class PolicyChangeLife{
        public string TransactionCode {get; set;}
        public string TransactionDescription {get; set;}
        public Date SubmitDate {get; set;}
        public Date CreateDate {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}        
        
        public PolicyChangeLife(){
        }       
    } 
    
    public class EndorsementGI{
        public string CertificateNo {get; set;}
        public string ContractType {get; set;}
        public Date InforceDate {get; set;}
        public Date StartDate {get; set;}
        public Date EndDate {get; set;}
        public string EndorsementRemark {get; set;}
        public string StatusDescription {get; set;}
        public string TypeDescription {get; set;}    
        
        public EndorsementGI(){
        }       
    }    
    

    /* Risk Info
     * base on End to End Document
     * by Doddy 2016
     */
    public class RiskInfo{
        public string TahunPertanggungan {get; set;}
        public string TSI {get; set;}
        public decimal Premium {get; set;}
        public string Coverage {get; set;}
        public date StartDate {get; set;}
        public date EndDate {get; set;}     
        public string TransactionNo {get; set;}
        public string MemberNo {get; set;}
        public string MemberName {get; set;}
        public string PlanNo {get; set;}
        public string RiskNo {get; set;}
        
        public RiskInfo(){
        }       
    } 
    
    /* Risk Detail
     * base on End to End Document
     * 25 Nov 2019
     */
    public class RiskDetail{
        public string TahunPertanggungan {get; set;}
        public string TSI {get; set;}
        public decimal Premium {get; set;}
        public string Coverage {get; set;}
        public date StartDate {get; set;}
        public date EndDate {get; set;}     
        public string TransactionNo {get; set;}
        public string MemberNo {get; set;}
        public string MemberName {get; set;}
        public string PlanNo {get; set;}
        public string RiskNo {get; set;}
        
        public RiskDetail(){
        }       
    } 

    /* Own Risk
     * base on End to End Document
     * by Doddy 2016
     */
    public class OwnRisk{
        public string OwnRetentionDeductibleRemarks {get; set;}
        
        public OwnRisk(){
        }       
    } 


    /* Interest Info
     * base on End to End Document
     * by Doddy 2016
     */
    public class  InterestInfo{
        public string AdditionalBenefit  {get; set;}
        public string sLimit {get; set;}
        
        public InterestInfo(){
        }       
    }  
    
    /* Payment History
     * base on End to End Document
     * by Doddy 2016
     */
    public class  PaymentHistoryLife{
        public string PaymentMethod {get; set;}
        public Date PaymentSubmissionDate {get; set;}
        public Date PaymentTransactionDate {get; set;}
        public Date PaymentDueDate {get; set;}
        public decimal PaymentAmount {get; set;}
        public string PaymentType {get; set;}
        
        public PaymentHistoryLife(){
        }       
    }      

    public class  PaymentHistoryGI{
        public string PaymentMethod {get; set;}
        public Date PaymentSubmissionDate {get; set;}
        public Date PaymentTransactionDate {get; set;}
        public Date PaymentDueDate {get; set;}
        public decimal PaymentAmount {get; set;}
        
        public PaymentHistoryGI(){
        }       
    }      


    /* Fund History
     * base on End to End Document
     * by Doddy 2016
     */
    public class  FundHistory{
        public string ULFundCode {get; set;}
        public date FundPriceDate {get; set;}
        public decimal TransactionUnit {get; set;}
        public decimal UnitPrice {get; set;}
        public decimal TransactionAmount {get; set;}
        public string TransactionDescription {get; set;}
        public date TransactionDate {get; set;}
        public date TransactionEffectiveDate {get; set;}
        public date ULValuationDate {get; set;}
        public string ProcessingType {get; set;}
        public string ProcessingMode {get; set;}
        
        public FundHistory(){
        }       
    } 

    /* Fund Details
     * base on End to End Document
     * by Doddy 2016
     */
    public class  FundDetail{
        public string FundCode {get; set;}
        public decimal FundAllocation {get; set;}
        public decimal FundPrice {get; set;}
        public decimal TotalUnitFund {get; set;}
        public decimal TotalFundAmount {get; set;}
        public date NAVDate {get; set;}
        public decimal FundAmount {get; set;}
        public string FundUnit {get; set;}
        public decimal FundTotal {get; set;}
        public date FundNAVDate {get; set;}

        public FundDetail(){
        }       
    }  

    /* Fund Price History
     * base on End to End Document
     * by Doddy 2016
     */
    public class  FundPriceHistory{
        public decimal BidPrice_UnitPrice {get; set;}
        public decimal OfferPrice_UnitPrice {get; set;}
        public date ValuationDate {get; set;}
        public string FundCurrency {get; set;}
        public string FundCode {get; set;}
        public string FundDescription {get; set;}
        
        public FundPriceHistory(){
        }       
    } 
    
    /* Fund Assessment Notes Summary
     * base on End to End Document
     * by Doddy 2016
     */
    public class  AssessmentNotesSummary{
        public Datetime LastInputDateTime {get; set;}
        public String LastInputDateTimeOrigStr {get; set;}
        public string Section {get; set;}
        public string TranTypeClaimType {get; set;}
        public string RefNo {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}
        public string assessmentClassType {get; set;}
        
               
        public AssessmentNotesSummary(){
        }       
    } 

    /* Fund Assessment Notes Detail
     * base on End to End Document
     * by Doddy 2016
     */
    public class  AssessmentNotesDetail{
        public Datetime InputDateTime {get; set;}
        public string UserIDAssessment {get; set;}
        public string Description {get; set;}
        public string Section {get; set;} 
        public string assessmentClassType {get; set;}
               
        public AssessmentNotesDetail(){
        }       
    }    
        
    /* Fund Cash Value Detail
     * base on End to End Document
     * by Doddy 2016
     */
    public class  CashValueDetail{
        public decimal Loan {get; set;}
        public decimal LoanInterest {get; set;}
        public decimal Dividend {get; set;}
        public decimal DividendInterest {get; set;}
        public decimal FuturePremiumDeposit {get; set;}
        public decimal FuturePremiumDepositInterest {get; set;}
        public decimal CashValue {get; set;}
                       
        public CashValueDetail(){
        }       
    }    

    /* Fund Account Detail
     * base on End to End Document
     * by Doddy 2016
     */
    public class  AccountDetail{
        public string AccountNo {get; set;}
        public string AccountName {get; set;}
        public Date AccountEffectiveDate {get; set;}
        public Date AccountExpiredDate {get; set;}
        public string AccountType {get; set;}
        public string AccountStatus {get; set;}
        public string CollectionBank {get; set;}
        public string Branch {get; set;}
        public string RejectCode {get; set;}
        public Date RejectDate {get; set;}
        
        public AccountDetail(){
        }       
    }   
    
    
    /* Claim
     * base on End to End Document
     * by Doddy 2016
     */
    public class ClaimDetailLife {
        public string ProductType    {get; set;}
        public string ClaimNo    {get; set;}
        public string ClaimType      {get; set;}
        public string ClaimPlan      {get; set;}
        public date  ClaimSubmissionDate  {get; set;}
        public date  ClaimApprovalDate    {get; set;}
        public decimal ClaimAmount         {get; set;}
        public string ClaimCurrency  {get; set;}
        public string ClaimStatus1   {get; set;}
        public string ClaimStatus2   {get; set;}
        public string ClaimStatus   {get; set;}    
        
        public ClaimDetailLife(){
        }       
    }
    
    public class ClaimDetailGI {
        //public string PolicyNo    {get; set;}
        public string Product {get; set;}
        public string ClaimRegistrationNo {get; set;}
        public string ClaimStatus {get; set;}
        public string BranchCode {get; set;}
        public string ClientName {get; set;}
        public date NotificationDate {get; set;}
        public date RegistrationDate {get; set;}
        public date DateofLoss {get; set;}
        public string Description {get; set;}
        public string AccidentPlace {get; set;}
        public string RepairShop {get; set;}
        public date ApprovalPaymentDate {get; set;}
        public date PaymentDate {get; set;}
        public date DateOfReclaim {get; set;}
        public string DriverName {get; set;}
        public string BenefitOfType {get; set;}
        public date DischargeDate {get; set;}
        public string InsuredName {get; set;}
        public string Intermediary {get; set;}
        public string Accessor {get; set;}
        public string Occupation {get; set;}
        public string PayeeName {get; set;}
        public string Payee {get; set;}
        public date AuthDate {get; set;}
        public string Conveyance {get; set;}
        public decimal PaymentAmount {get; set;}
        public string Situation {get; set;}
        public date TransactionDate {get; set;}
        public string ClaimHandler {get; set;}
        public string VesselName {get; set;}
        public string VesselType {get; set;}
        public string PaymentNumber {get; set;}
        public string InsuredPerson {get; set;}
        public decimal Paid {get; set;}
        
        public ClaimDetailGI(){
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

    public class Benefit{
        public string PlanCode    {get; set;}
        public string BenefitCode  {get; set;}
        public string BenefitDesc  {get; set;}
        public decimal BenefitInDay  {get; set;}
        public decimal BenefitInVisit  {get; set;}
        public decimal BenefitInMonth  {get; set;}
        public decimal BenefitInYear  {get; set;}
        public decimal BenefitInLife  {get; set;}
        
        public Benefit(){
        }       
    }    

    public class TrxPayment{
        public string TransactionType    {get; set;}
        public date  SubmissionDate  {get; set;}
        public date  PaymentDate     {get; set;}
        public date  DueDate     {get; set;}
        public decimal Amount  {get; set;}
        
        public TrxPayment(){
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
    
    public class CashValueDetail_OLD{
        public decimal Loan    {get; set;}
        public decimal LoanInterest {get; set;}
        public decimal Dividend {get; set;}
        public decimal DividendInterest {get; set;}
        public decimal FtrPremDeposit  {get; set;}
        public decimal FtrPremDepInter  {get; set;}
        public decimal CashValue {get; set;}
        
        public CashValueDetail_OLD(){
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
        
        public TrxClaim(){
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

    public class PremiumBreakdown_OLD{
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
        
        public PremiumBreakdown_OLD(){
        }       
    }
    
    public class PolicyChange{ 
        public string TransactionCode   {get; set;}
        public string TransactionDesc  {get; set;}
        public date SubmitDate {get; set;}
        public date CreateDate {get; set;}
        public string Status {get; set;}
        public string Remark {get; set;}
        
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
    
    public class AccountDetail_OLD{
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
        
        public AccountDetail_OLD(){
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
    
    public class InterestInfo_OLD{
        public string AddCoverCode  {get; set;}
        public string AddCoverName {get; set;}
        public string AddCoverType {get; set;}
        public decimal AddCoverPremium {get; set;}
        public decimal SIofAddCover   {get; set;}
        
        public InterestInfo_OLD(){
        }       
    }   
    
    // .end of previous inner class
    // ------------------------------------------
    

    // New inner class by doddy
    // ------------------------------------------
    
    /** Assesment Notes Summary 
    **/
    public class AssNotes{
        public string submittedDate {get;set;}
        public string submittedBy {get;set;}
      
    }
    
    /** Assesment Notes Detail 
    **/
    public class AssNotesDetail{
        public string inputDate {get;set;}
        public string userID {get;set;}
        public string userName {get;set;}
        public string description {get;set;}
        public string section {get;set;}
        
    }
    
    /** Assesment Notes Summary : JSON Structure 
    **/
    global class AssNotesJSON {
        public String key {get;set;}
        public String status {get;set;}
        public Integer pageno {get;set;}
        public Integer startrecord {get;set;}
        public Integer endrecord {get;set;}
        public Integer totalrecords {get;set;}
        public List <assNotes> data {get;set;}
    }
    
    
    /** Assesment Notes Detail : JSON Structure 
    **/    
    public class AssNotesDetailJSON {
        public String key {get;set;}
        public String status {get;set;}
        public Integer pageno {get;set;}
        public Integer startrecord {get;set;}
        public Integer endrecord {get;set;}
        public Integer totalrecords {get;set;}
        public List <assNotesDetail> data {get;set;}
    }
    
    public class DataLoadSquence {
        string entity {get; set;}
        
        public DataLoadSquence () {
        }
    }

    /*****-------  SET JSON DATA AND MAPPING -------- ****/
    public string contactIDRemote {
        get {
            return null;
        }
        set {
            system.debug('>>> on contactIDRemote ');
            contactID = value.unescapeHtml4();
            initPolicyInfo();
            system.debug('>>> on contactIDRemote DONE ');
        }
    }
        
    public String customerInfoJSON {
        get {
            return customerInfoJSON;
        } 
        set {
            system.debug('>>> on customerInfoJSON ');
            string jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            customerInfoData = new CustomerInfo();
            //customerInfoData = null;
            
            customerInfoJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        
                        customerInfoData.policyOwnerID = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::customerID'); system.debug('====== SET TO        : policyOwnerID         ' );
                        customerInfoData.gender = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::genderCD'); system.debug('====== SET TO        : gender         ' );
                        customerInfoData.dateOfBirth = (date)CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::birthDT'), 'yyyymmdd'); system.debug('====== SET TO        : dateOfBirth         ' );
                        customerInfoData.age = CCCUtils.birthToAge (customerInfoData.dateOfBirth); /*//'36'; // formula from date of birth */ system.debug('====== SET TO        : Age         ' );
                        customerInfoData.placeOfBirth = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::birthPlace'); system.debug('====== SET TO        : placeOfBirth         ' );
                        customerInfoData.address1 = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn[0]::addressLine1'); system.debug('====== SET TO        : address1         ' );
                        customerInfoData.address2 = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn[0]::addressLine2'); system.debug('====== SET TO        : address2         ' );
                        customerInfoData.address3 = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn[0]::addressLine3'); system.debug('====== SET TO        : address3         ' );
                        customerInfoData.address4 = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn[0]::addressLine4'); system.debug('====== SET TO        : address4         ' );
                        customerInfoData.agentServicingCode = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasPartyDetailsIn[0]::servicingCD').substring(8,14); system.debug('====== SET TO        : agentServicingCode         ' );
                        customerInfoData.agentProducingCode = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasPartyDetailsIn[0]::producingCD'); system.debug('====== SET TO        : agentProducingCode         ' );
                
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getCustomerInfo -  Customer Profile) ' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getCustomerInfo -  Customer Profile)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Customer Info data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getCustomerInfo -  Customer Profile)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getCustomerInfo -  Customer Profile)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Customer Info data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }
    
    public String beneficiaryDetailJSON {
        get {
            return beneficiaryDetailJSON;
        }
        set {
            system.debug('>>> on beneficiaryDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            
            beneficiaryDetailList = new List<BeneficiaryDetail>();
            //beneficiaryDetailList = null;
            
            beneficiaryDetailJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        // List<Object> objHasBeneficiaryInformationInList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::forLifeUnitofExposure[0]::hasBeneficiaryInformationIn');
                        List<Object> objHasBeneficiaryInformationInList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::forLifeUnitofExposure');
                        List <BeneficiaryDetail> beneficiaryDetailListTMP = new List <BeneficiaryDetail>();
                        for (Object oo : objHasBeneficiaryInformationInList) {
                            Map<String, Object> mapRec2 = (Map<String, Object>) oo;
                                
                            BeneficiaryDetail dataRec = new BeneficiaryDetail();
            
                            //dataRec.Name = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::firstNM');
                            dataRec.Name = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::firstNM') + ' ' +
                                                    CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::middleNM') + ' ' +
                                                    CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::lastNM');
                            dataRec.DateOfBirth  = (date) CCCUtils.strToDate ((string) (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::birthDT'), 'yyyymmdd');
                            dataRec.PlaceofBirth  = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::birthPlace');
                            dataRec.Gender  = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::canBeIndividual[0]::genderCD'); 
                            
                            dataRec.Relation = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::hasBeneficiaryXUoeDetailsIn[0]::relationshipToInsuredCD');
                            dataRec.Percentage = (string) CCCUtils.getStringDataOnMap(mapRec2, 'hasBeneficiaryInformationIn::hasBeneficiaryXUoeDetailsIn[0]::benefitDistributionPCT');
                            
                            beneficiaryDetailListTMP.add(dataRec);              
                        }
                        beneficiaryDetailList=beneficiaryDetailListTMP;
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getBeneficiaryDetail -  Beneficiary) ' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getBeneficiaryDetail -  Beneficiary)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Beneficiary data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getBeneficiaryDetail -  Beneficiary)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getBeneficiaryDetail -  Beneficiary)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Beneficiary data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String benefitDetailJSON {
        get {
            return benefitDetailJSON;
        }
        set {
            system.debug('>>> on benefitDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            
            benefitDetailList = new List<BenefitDetail>();
            //benefitDetailList = null;
            
            benefitDetailJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        // List<Object> objHasBeneficiaryInformationInList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::forLifeUnitofExposure[0]::hasBeneficiaryInformationIn');
                        List<Object> objHasBenefitInformationInList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::isAssociatedWithLifeInsuranceProduct');
                        List <BenefitDetail> benefitDetailListTMP = new List <BenefitDetail>();
                        for (Object oo : objHasBenefitInformationInList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            BenefitDetail dataRec = new BenefitDetail();
            
                            dataRec.PlanCode = (string) CCCUtils.getStringDataOnMap(mapRec, 'planCd');
                            dataRec.BenefitCode = (string) CCCUtils.getStringDataOnMap(mapRec, 'planTypeCD');
                            dataRec.BenefitDesc = (string) CCCUtils.getStringDataOnMap(mapRec, 'benefitDesc');
                            String benefitRK_Temp = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitRK');

                            if (benefitRK_Temp == 'visit') dataRec.BenefitInVisit = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitAMT'));
                            else if (benefitRK_Temp == 'day') dataRec.BenefitInDay = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitAMT'));
                            else if (benefitRK_Temp == 'month') dataRec.BenefitInMonth = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitAMT'));
                            else if (benefitRK_Temp == 'year') dataRec.BenefitInYear = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitAMT'));
                            else if (benefitRK_Temp == 'life') dataRec.BenefitInLife = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0].benefitAMT'));
                            
                            benefitDetailListTMP.add(dataRec);              
                        }
                        benefitDetailList=benefitDetailListTMP;
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getBenefitDetail -  Benefit) ' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getBenefitDetail -  Benefit)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Benefit data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getBenefitDetail -  Benefit)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getBenefitDetail -  Benefit)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Beneficiary data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String premiumBreakdownJSON {
        get {
            return premiumBreakdownJSON;
        }
        set {
            system.debug('>>> on premiumBreakdownJSON ');
            String jsonStr = value.unescapeHtml4();
            
            premiumBreakdownList2 = new List<PremiumBreakdown>();
            //premiumBreakdownList = null;
            
            premiumBreakdownJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        
                        string PolicyNo = (string) (string) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyNO');
                        Date EffectiveDate = null;
                        Date ExpiredDate = null;
                        Date checkTerminationDate = null;
                            
                        if(CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyEffectiveDTTM') != null){
                            EffectiveDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyEffectiveDTTM'), 'yyyymmdd' );
                        }
                            
                        if(CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyExpirationDTTM') != null){
                            ExpiredDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyExpirationDTTM'), 'yyyymmdd' );    
                        }
                            
                        List<Object> objIsAssociatedWithLifeInsuranceProductList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::isAssociatedWithLifeInsuranceProduct');
                        
                        if(CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::isAssociatedWithLifeInsuranceProduct::terminationDt') != null){
                            checkTerminationDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::isAssociatedWithLifeInsuranceProduct::terminationDt'), 'yyyymmdd');
                        }
                            
                        List <PremiumBreakdown> premiumBeakdownListTMP = new List <PremiumBreakdown>();
                        for (Object oo : objIsAssociatedWithLifeInsuranceProductList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            PremiumBreakdown dataRec = new PremiumBreakdown();
                            
                            //dataRec.PolicyNo = PolicyNo;
                            //dataRec.InsuranceProductCd = (string) CCCUtils.getStringDataOnMap(mapRec, 'insuranceProductCd');
                            dataRec.TransactionNo = (string) CCCUtils.getStringDataOnMap(mapRec, 'policyProductFormCd');
                            dataRec.ProductType = (string) CCCUtils.getStringDataOnMap(mapRec, 'productTypeCD');
                            //dataRec.GrossPremium = CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsRecordIn[0]::minAnnualizedPayment');
                            //dataRec.NettPremium = CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsRecordIn[0]::minModalPayment');
                            dataRec.RiskNo = (string) CCCUtils.getStringDataOnMap(mapRec, 'guarRateInd');
                            dataRec.InsuredNo = (string) CCCUtils.getStringDataOnMap(mapRec, 'insuranceProductCd');
                            dataRec.InsuredName = (string) CCCUtils.getStringDataOnMap(mapRec, 'insuranceProductRk');
                            dataRec.PlanCode = (string) CCCUtils.getStringDataOnMap(mapRec, 'planCd');
                            dataRec.PlanType = (string) CCCUtils.getStringDataOnMap(mapRec, 'planTypeCD');
                            //dataRec.PlanEffectiveDate = (date) CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec, 'saleEffectiveDt'), 'yyyymmdd');
                            dataRec.PlanEffectiveDate = EffectiveDate;
                            //dataRec.PlanExpiredDate = (date) CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec,    'saleExpirationDt'), 'yyyymmdd');
                            dataRec.PlanExpiredDate = ExpiredDate;
                            dataRec.PlanSI = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasPlanDetailsIn[0]::planSI'));
                            dataRec.ModalPlanPremium = CCCUtils.strToDec(  CCCUtils.getStringDataOnMap(mapRec,  'hasPlanDetailsIn[0]::premium'));
                            dataRec.PlanStatus = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasPlanDetailsIn[0]::planStatus');
                            dataRec.ClassCode = (string) CCCUtils.getStringDataOnMap(mapRec, 'planClassCD');
                            dataRec.ModalPlanLoading = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec,   'hasPlanDetailsIn[0]::modalPlanLoading') ) ;
                            
                            if(checkTerminationDate != null){
                                dataRec.TerminationDate = (date) CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec,    'terminationDt'), 'yyyymmdd');
                            } else {
                                dataRec.TerminationDate = null;
                            }
                            
                            //dataRec.EffectiveDate = EffectiveDate;
                            //dataRec.ExpiredDate = ExpiredDate; 

                            premiumBeakdownListTMP.add(dataRec);                
                        }
                        premiumBreakdownList2=premiumBeakdownListTMP;
                        
                        system.debug('==== value premiumBreakdownList2 : '+  premiumBreakdownList2);
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getPremiumBreakdown - Premium Breakdown) ' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getPremiumBreakdown - Premium Breakdown)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Premium Breakdown data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getPremiumBreakdown - Premium Breakdown)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getPremiumBreakdown - Premium Breakdown)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Premium Breakdown data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String policyChangeLifeJSON {
        get {
            return policyChangeLifeJSON;
        }
        set {
            system.debug('>>> on policyChangeLifeJSON ');
            String jsonStr = value.unescapeHtml4();
            
            policyChangeLifeList = new List<PolicyChangeLife>();
            //policyChangeLifeList = null;
            
            policyChangeLifeJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        
                        //string PolicyNo = (string) (string) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyNO');
                        //Date EffectiveDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyEffectiveDTTM'), 'yyyymmdd' );
                        //Date ExpiredDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyExpirationDTTM'), 'yyyymmdd' );  
                        
                        List<Object> objHasLifePolicyTransactionDetailsInList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                              
                        List <PolicyChangeLife> policyChangeLifeListTMP = new List <PolicyChangeLife>();
                        for (Object oo : objHasLifePolicyTransactionDetailsInList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            PolicyChangeLife dataRec = new PolicyChangeLife();
                            dataRec.TransactionCode = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::transTypeCD');
                            dataRec.TransactionDescription = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::transDesc');
                            dataRec.SubmitDate = (date) CCCUtils.strToDate ( CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::processedDttm'), 'yyyymmdd');
                            dataRec.CreateDate = (date) CCCUtils.strToDate ( CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::transDT'), 'yyyymmdd');
                            dataRec.Status = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::transactionStatusCD');
                            dataRec.Remark  = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasLifePolicyTransactionDetailsIn::remark');
                            
                            policyChangeLifeListTMP.add(dataRec);               
                        }
                        policyChangeLifeList=policyChangeLifeListTMP;
                        system.debug('==== value policyChangeLifeList : '+  policyChangeLifeList);
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getPolicyDetails - Policy Change) ' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getPolicyDetails - Policy Change)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Policy Change data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getPolicyDetails - Policy Change)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getPolicyDetails - Policy Change)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Policy Change data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }               
            }
        }
    }

    public String endorsementGIJSON {
        get {
            return endorsementGIJSON;
        }
        set {
            system.debug('>>> on endorsementGIJSON ');
            String jsonStr = value.unescapeHtml4();
            
            endorsementGIList = new List<EndorsementGI>();
            //endorsementGIList = null;
            
            endorsementGIJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        
                        //string PolicyNo = (string) (string) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyNO');
                        //Date EffectiveDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyEffectiveDTTM'), 'yyyymmdd' );
                        //Date ExpiredDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyExpirationDTTM'), 'yyyymmdd' );  
                        
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                              
                        List <EndorsementGI> endorsementGIListTMP = new List <EndorsementGI>();
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            EndorsementGI dataRec = new EndorsementGI();
    
                            dataRec.CertificateNo = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasGIPolicyEndorsementIn::certificateNo');
                            dataRec.ContractType = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasGIPolicyEndorsementIn::contractType');
                            dataRec.InforceDate = (date) CCCUtils.strToDate ( CCCUtils.getStringDataOnMap(mapRec, 'hasGIPolicyEndorsementIn::inforceDate'), 'yyyymmdd');
                            dataRec.StartDate = (date) CCCUtils.strToDate ( CCCUtils.getStringDataOnMap(mapRec, 'issueDt'), 'yyyymmdd');
                            dataRec.EndDate = (date) CCCUtils.strToDate ( CCCUtils.getStringDataOnMap(mapRec, 'policyExpirationDTTM'), 'yyyymmdd');
                            dataRec.EndorsementRemark = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasGIPolicyEndorsementIn::endorsementRk');
                            dataRec.StatusDescription = (string) CCCUtils.getStringDataOnMap(mapRec, 'policyRK');
                            dataRec.TypeDescription  = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasGIPolicyEndorsementIn::typeDesc');
                                                
                            endorsementGIListTMP.add(dataRec);              
                        }
                        endorsementGIList=endorsementGIListTMP;
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getGIPolicyDetail - Policy Change)' + e.getMessage());
                    }
                    system.debug('========= value of endorsementGIList : ' + endorsementGIList);
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getGIPolicyDetail - Policy Change)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Endorsement data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (getGIPolicyDetail - Policy Change)');
                    } else {
                        system.debug ('================ JSON Response is Failed (getGIPolicyDetail - Policy Change)');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Endorsement data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }       

    public String insuredDetailLifeJSON {
        get {
            return insuredDetailLifeJSON;
        }
        set {
            system.debug('>>> on insuredDetailLifeJSON ');
            String jsonStr = value.unescapeHtml4();
            
            insuredDetailLifeList = new List<InsuredDetailLife>();
            //endorsementGIList = null;
            
            insuredDetailLifeJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation'); 
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                        
                        List <InsuredDetailLife> listTMP = new List <InsuredDetailLife>();
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                            List<Object> hasDetailsOfRisksIns = (List<Object>) CCCUtils.getListDataOnMap(mapRec, 'hasDetailsOfRisksIn');

                            for (Object hasDetailsOfRisksIn : hasDetailsOfRisksIns) {
                                Map<String, Object> hasDetailsOfRisksInMap = (Map<String, Object>) hasDetailsOfRisksIn;
                                InsuredDetailLife dataRec = new InsuredDetailLife();

                                dataRec.IDNo = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'insuredID');
                                dataRec.Depno = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'agrRk');
                                // dataRec.Name = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasDetailsOfRisksIn::hasPersonalDetailsIn::firstNM');
                                dataRec.Name = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::firstNM') + ' ' +
                                                        CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::middleNM') + ' ' +
                                                        CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::lastNM');
                                dataRec.PlaceofBirth = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::birthPlace');
                                dataRec.DateofBirth = (Date) CCCUtils.strToDate( CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::birthDT'), 'yyyymmdd');
                                dataRec.Gender = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::genderCD');
                                dataRec.Email = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::hasAddressesIn::emailAddress');
                                dataRec.Mobile = (string) CCCUtils.getStringDataOnMap(hasDetailsOfRisksInMap, 'hasPersonalDetailsIn::hasAddressesIn::mobilePhoneNO');
                                
                                listTMP.add(dataRec);
                            }
                        }
                        insuredDetailLifeList = listTMP;
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }    
            }
        }
    }

    public String policyDetailLifeJSON {
        get {
            return policyDetailLifeJSON;
        } 
        set {
            system.debug('>>> on policyDetailLifeJSON ');
            string jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            policyDetailLifeData = new policyDetailLife();
            //policyDetailLifeData = null;
            
            policyDetailLifeJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');     
                        //policyDetailLifeJSON = (string) packageData.get('jsonStr');       
                        
                        policyDetailLifeData.SourceCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::sourceChannelCD'); system.debug('====== SET TO        : SourceCode ');
                        policyDetailLifeData.PlanCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::isAssociatedWithLifeInsuranceProduct[0]::planCd'); system.debug('====== SET TO        : PlanCode ');
                        
                        policyDetailLifeData.PlanName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::isAssociatedWithLifeInsuranceProduct[0]::planNM');     system.debug('====== SET TO        : PlanName ');
                        
                        policyDetailLifeData.PolicyStatus  =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyStatusCD'); system.debug('====== SET TO        : PolicyStatus');
                        //policyDetailLifeData.PolicyStatusDescription =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyStatusRk');
                        policyDetailLifeData.ApplicationDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasApplicationDetailsIn[0]::applicationDTTM'), 'yyyymmdd'); system.debug('====== SET TO        : ApplicationDate ');
                        policyDetailLifeData.IssueDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::issueDt'), 'yyyymmdd');   system.debug('====== SET TO        : IssueDate ');
                        //policyDetailLifeData.issueDateString = CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::issueDt');   system.debug('====== SET TO        : issueDateString ');
                        policyDetailLifeData.EffectiveDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyEffectiveDTTM'), 'yyyymmdd');   system.debug('====== SET TO        : EffectiveDate ');
                        policyDetailLifeData.ExpiredDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyExpirationDTTM'), 'yyyymmdd');    system.debug('====== SET TO        : ExpiredDate ');
                        policyDetailLifeData.DueDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyDueDt'), 'yyyymmdd'); system.debug('====== SET TO        : DueDate ');
                        policyDetailLifeData.TerminationDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::terminationDt'), 'yyyymmdd');   system.debug('====== SET TO        : TerminationDate ');
                        
                        policyDetailLifeData.TotalPremium =  CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::premiumAMT')) ;  system.debug('====== SET TO        : TotalPremium ');
                        policyDetailLifeData.TotalSumInsured =  CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::isAssociatedWithLifeInsuranceProduct[0]::hasPolicySegmentDetailsIn[0]::sumInsured'));     system.debug('====== SET TO        : TotalSumInsured ');
                        policyDetailLifeData.TopUpPremium =  CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::topupRegularModalPremium') );   system.debug('====== SET TO        : TopUpPremium ');
                        policyDetailLifeData.InitialLumpSum =  CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::initialLumpsumPremiumAMT') ); system.debug('====== SET TO        : InitialLumpSum ');
                        policyDetailLifeData.currencyCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::currencyCD'); system.debug('====== SET TO        : currencyCode ');    
                        
                        policyDetailLifeData.PaymentMethod =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::paymentMethodCD');    system.debug('====== SET TO        : PaymentMethod ');
                        policyDetailLifeData.PaymentMode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::paymentModeCD');    system.debug('====== SET TO        : PaymentMode ');
                        policyDetailLifeData.StatusDescription =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyRK');   system.debug('====== SET TO        : StatusDescription ');
                        policyDetailLifeData.PremiumHolidayStartDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasLifePolicyChangeTransDetailsIn[0]::startPremiumHolidayDT'), 'yyyymmdd');     system.debug('====== SET TO        : PremiumHolidayStartDate ');
                        
                        policyDetailLifeData.PremiumHolidayEndDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasLifePolicyChangeTransDetailsIn[0]::endPremiumHolidayDT'), 'yyyymmdd'); system.debug('====== SET TO        : PremiumHolidayEndDate ');
                        policyDetailLifeData.ePolicy =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::ePolicy');  system.debug('====== SET TO        : ePolicy ');
                        
                        if(policyApp.toUpperCase() == 'BIS' || policyApp.toUpperCase() == 'DMTM' ) { policyDetailLifeData.MataUang = 'Rp'; }
                        else if (policyApp.toUpperCase() == 'RLS'){ policyDetailLifeData.MataUang = policyDetailLifeData.currencyCode; }
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getPolicyDetails - Policy Details)' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getPolicyDetails - Policy Details)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Policy Details data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                } 
            }
        }
    }
    
    public String riskInfoJSON {
        get {
            return riskInfoJSON;
        }
        set {
            system.debug('>>> on riskInfoJSON ');
            String jsonStr = value.unescapeHtml4();
            
            riskInfoList = new List<RiskInfo>();
            //riskInfoList = null;
            
            riskInfoJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objHasPolicyAccountList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                        
                        //---- 22 Nov 2019
                        //List<Object> objHasPolicyAccountList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::isAssociatedWithLifeInsuranceProduct');
                        //END - 22 Nov 2019
                        
                        List <RiskInfo> riskInfoListTMP = new List <RiskInfo>();
                        for (Object oo : objHasPolicyAccountList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            RiskInfo dataRec = new RiskInfo();
                            
                            //---- 22 Nov 2019
                            dataRec.TahunPertanggungan =  CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfGIRisksIn[0]::coverageEndDT');
                            dataRec.TSI  =  CCCUtils.getStringDataOnMap(mapRec, 'isAssociatedWithGIInsuranceProduct[0]::hasGIPolicySegmentDetailsIn[0]::sumInsured');
                            dataRec.Premium =  CCCUtils.strToDec (CCCUtils.getStringDataOnMap(mapRec, 'premiumAMT'));  
                            dataRec.Coverage =  CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfGIRisksIn[0]::coverageRk'); 
                            dataRec.StartDate =  CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec, 'issueDt'), 'yyyymmdd');
                            dataRec.EndDate =  CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec, 'policyExpirationDTTM'), 'yyyymmdd');
                            
                            /*dataRec.Coverage =  CCCUtils.getStringDataOnMap(mapRec, 'planCD'); 
                            dataRec.StartDate =  CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec, 'saleEffectiveDt'), 'yyyymmdd');
                            dataRec.EndDate =  CCCUtils.strToDate (CCCUtils.getStringDataOnMap(mapRec, 'terminationDt'), 'yyyymmdd');*/
                            dataRec.TransactionNo =  CCCUtils.getStringDataOnMap(mapRec, 'policyProductFormCd'); 
                            dataRec.MemberNo =  CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0]::benefitCD');
                            dataRec.MemberName =  CCCUtils.getStringDataOnMap(mapRec, 'hasBenefitDetailsIn[0]::benefitDESC');
                            dataRec.PlanNo =  CCCUtils.getStringDataOnMap(mapRec, 'hasPlanDetailsIn[0]::planSI'); 
                            dataRec.RiskNo =  CCCUtils.getStringDataOnMap(mapRec, 'guarRateInd'); 
                            riskInfoListTMP.add(dataRec);               
                        }
                        riskInfoList=riskInfoListTMP;
                    }  catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getGIPolicyDetail - RiskInfo)' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getGIPolicyDetail - RiskInfo)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'RiskInfo data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String ownRiskJSON {
        get {
            return ownRiskJSON;
        }
        set {
            system.debug('>>> on ownRiskJSON ');
            String jsonStr = value.unescapeHtml4();
            
            ownRiskData = new ownRisk();
            //ownRiskData = null;
            
            ownRiskJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');      
                        ownRiskData.OwnRetentionDeductibleRemarks = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasDetailsOfGIRisksIn::deductibleName');            

                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }   

    public String interestInfoJSON {
        get {
            return interestInfoJSON;
        }
        set {
            system.debug('>>> on interestInfoJSON ');
            String jsonStr = value.unescapeHtml4();
            
            interestInfoList = new List<InterestInfo>();
            //riskInfoList = null;
            
            interestInfoJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               

                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                        
                        List <InterestInfo> interestInfoListTMP = new List <InterestInfo>();
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            InterestInfo dataRec = new InterestInfo();
                            /*
                                public string AdditionalBenefit  {get; set;}
                                public string sLimit {get; set;}
                            */      

                            dataRec.AdditionalBenefit = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfGIRisksIn::otherBenefit::benefitDESC');
                            dataRec.sLimit = (string) CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfGIRisksIn::otherBenefit::benefitAMT');
                            
                            interestInfoListTMP.add(dataRec);               
                        }
                        interestInfoList=interestInfoListTMP;
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }   
            }
        }
    }   

    public String assNotesSummaryUWJSON {
        get{
            return assNotesSummaryUWJSON;
        }
        set{
            assessmentNotesSummaryUWList = new List<AssessmentNotesSummary>();
            assNotesJSON = value.unescapeHtml4();
        } 
    }   
    
    //public String assNotesSummaryUWJSON {     
    public String assNotesJSON {
        get {
            return assNotesJSON;
            //return assNotesSummaryUWJSON;
        }
        set {
            system.debug('>>> on assNotesJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            assessmentNotesDetailList = new List<AssessmentNotesDetail>();
            
            assNotesJSON = jsonStr;
            //assNotesSummaryUWJSON = jsonStr;
            
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                string assessmentClassType ='';
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPolicyAssessmentDetailsIn');
                        
                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));
                        integer lastPageNo =0;
                        
                        if (objList.size() < numberOfRecords) {
                            lastPageNo = pageNumber;
                        }
                        system.debug('== assnotes lastPageNo :' + lastPageNo );
                              
                        List <AssessmentNotesSummary> summaryListTMP = new List <AssessmentNotesSummary>();
                        List <AssessmentNotesDetail> detailListTMP = new List <AssessmentNotesDetail>();
                        
                        operation = CCCUtils.getStringDataOnMap(mapData, 'Body::operation');
                        operation = operation.trim();
                        
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                            
                            // Summary
                            if (operation == 'Summary') {
                                AssessmentNotesSummary dataRec = new AssessmentNotesSummary();
                                
                                dataRec.LastInputDateTimeOrigStr=CCCUtils.getStringDataOnMap(mapRec, 'lastUpdDTTM');
                                dataRec.LastInputDateTime =  CCCUtils.strToDateTime ( dataRec.LastInputDateTimeOrigStr, 'yyyymmddhhmmss');
                                dataRec.Section  =  CCCUtils.getStringDataOnMap(mapRec, 'assmtSection').trim(); 
                                dataRec.TranTypeClaimType =  CCCUtils.getStringDataOnMap(mapRec, 'assmtTypeCd').trim();  
                                dataRec.RefNo =  CCCUtils.getStringDataOnMap(mapRec, 'assmtRefNo').trim(); 
                                dataRec.Status = CCCUtils.getStringDataOnMap(mapRec, 'assmtStatus').trim();
                                dataRec.Remark =  CCCUtils.getStringDataOnMap(mapRec, 'assmtRemark').trim();               
                                dataRec.assessmentClassType = CCCUtils.getStringDataOnMap(mapRec, 'assessmentClassType').trim();
                                
                                if (assessmentClassType == ''){
                                    assessmentClassType = dataRec.assessmentClassType;
                                    system.debug ('== assessmentClassType1 : '+ assessmentClassType);
                                }
                                system.debug ('== assessmentClassType2 : '+ assessmentClassType);
                                summaryListTMP.add(dataRec);    
                            }
                            else if (operation == 'Detail') {
                                AssessmentNotesDetail dataRec = new AssessmentNotesDetail();
                                
                                dataRec.InputDateTime =  CCCUtils.strToDateTime ( CCCUtils.getStringDataOnMap(mapRec, 'lastUpdDTTM'), 'yyyymmddhhmmss');
                                dataRec.UserIDAssessment  =  CCCUtils.getStringDataOnMap(mapRec, 'lastUpdBy'); 
                                dataRec.Description =  CCCUtils.getStringDataOnMap(mapRec, 'assmtDesc').replaceAll('\\n','<br/>').replace(' ','&nbsp;');
                                dataRec.Section = CCCUtils.getStringDataOnMap(mapRec, 'assmtSection');              
                                dataRec.assessmentClassType = CCCUtils.getStringDataOnMap(mapRec, 'assessmentClassType');
                                assessmentClassType = dataRec.assessmentClassType;
                                
                                detailListTMP.add(dataRec);
                            }           
                        }
                        assessmentClassType = assessmentClassType.trim();
                        
                        ///assessmentNotesSummaryPOSList = summaryListTMP;
                        system.debug ('== assessmentClassType3 : '+ assessmentClassType);
                        system.debug ('== summaryListTMP : '+ summaryListTMP);
                                                
                        system.debug ('== operation : '+ operation);
                        
                        if (operation == 'Summary') {
                            system.debug ('== in SUMMARY');
                            
                            if (summaryListTMP.size()==1 && summaryListTMP[0].LastInputDateTime==null) {
                                lastPageNo = pageNumber-1;
                            }
                            system.debug('== assnotes summary lastPageNo :' + lastPageNo );
                            
                            if (assessmentClassType == 'POS') {
                                assessmentNotesSummaryPOSList = new List<AssessmentNotesSummary>();
                                assessmentNotesSummaryPOSList=summaryListTMP;
                                assessmentNotesSummaryPOSJSON=jsonStr;
                                assessmentNotesSummaryPOSLastPageNo = lastPageNo;
                            } else if (assessmentClassType == 'PA') {
                                system.debug ('== in PA');
                                assessmentNotesSummaryPAList = new List<AssessmentNotesSummary>();
                                assessmentNotesSummaryPAList=summaryListTMP;
                                assessmentNotesSummaryPAJSON=jsonStr;
                                assessmentNotesSummaryPOSLastPageNo = lastPageNo;
                            } else if (assessmentClassType == 'UW') {
                                assessmentNotesSummaryUWList = new List<AssessmentNotesSummary>();
                                assessmentNotesSummaryUWList=summaryListTMP;
                                assessmentNotesSummaryUWJSON=jsonStr;
                                assessmentNotesSummaryUWLastPageNo = lastPageNo;
                            } else if (assessmentClassType == 'OTH') {
                                assessmentNotesSummaryOTHList = new List<AssessmentNotesSummary>();
                                assessmentNotesSummaryOTHList=summaryListTMP;
                                assessmentNotesSummaryOTHJSON=jsonStr;
                                assessmentNotesSummaryOTHLastPageNo = lastPageNo;
                            } else if (assessmentClassType == 'CLM') {
                                assessmentNotesSummaryCLMList = new List<AssessmentNotesSummary>();
                                assessmentNotesSummaryCLMList=summaryListTMP;
                                assessmentNotesSummaryCLMJSON=jsonStr;
                                assessmentNotesSummaryCLMLastPageNo = lastPageNo;
                            }

                        } else if (operation == 'Detail'){
                            if (detailListTMP.size()==1 && detailListTMP[0].InputDateTime==null) { lastPageNo = pageNumber-1; }
                            system.debug('== assnotes detail lastPageNo :' + lastPageNo );
                            
                            assessmentNotesDetailList = new List<AssessmentNotesDetail>();
                            assessmentNotesDetailList = detailListTMP;
                            assessmentNotesDetailJSON=jsonStr;
                            assessmentNotesDetailLastPageNo = lastPageNo;
                        }
                        
                        system.debug ('== assessmentNotesSummaryPOSJSON : '+ assessmentNotesSummaryPOSJSON);
                        system.debug ('== assessmentNotesSummaryPAJSON : '+ assessmentNotesSummaryPAJSON);
                        system.debug ('== assessmentNotesSummaryUWJSON : '+ assessmentNotesSummaryUWJSON);
                        system.debug ('== assessmentNotesSummaryOTHJSON : '+ assessmentNotesSummaryOTHJSON);
                        system.debug ('== assessmentNotesSummaryCLMList : '+ assessmentNotesSummaryCLMList  );
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getAssNotes - '+ operation + ' - ' + assessmentClassType + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getAssNotes - '+ operation + ' - ' + assessmentClassType + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'AssNotes - '+ operation + ' ' + assessmentClassType + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ' - ' + assessmentClassType + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ' - ' + assessmentClassType + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'AssNotes - ' +  operation + ' - ' + assessmentClassType + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String cashValueDetailJSON {
        get {
            return cashValueDetailJSON;
        }
        set {
            system.debug('>>> on cashValueDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            //system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            cashValueDetailList =  new List<CashValueDetail>();
            //cashValueDetailList = null;
            
            cashValueDetailJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objHasPolicyAccountList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                              
                        List <CashValueDetail> cashValueDetailListTMP = new List <CashValueDetail>();
                        for (Object oo : objHasPolicyAccountList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            CashValueDetail dataRec = new CashValueDetail();

                            dataRec.Loan =  (decimal) CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::loanRepaymentAmt') );
                            dataRec.LoanInterest =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::loanIntTypeCd') );
                            dataRec.Dividend =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::dividendAmt') );
                            dataRec.DividendInterest =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::dividendTypeCD') );
                            dataRec.FuturePremiumDeposit =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::futurePremiumDpAmt') );
                            dataRec.FuturePremiumDepositInterest =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::futurePremiumDpIntTypeCode') );
                            dataRec.CashValue =  (decimal) CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'hasDetailsOfPolicyIn::gdbValue') );
                            
                            cashValueDetailListTMP.add(dataRec);                
                        }
                        
                        cashValueDetailList=cashValueDetailListTMP;
                        system.debug('====== value of cashValueDetailList : ' + cashValueDetailList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (getPolicyDetails - Cash Value)' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getPolicyDetails - Cash Value)');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Cash Value data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String policyDetailGIJSON {
        get {
            return policyDetailGIJSON;
        } 
        set {
            system.debug('>>> on policyDetailGIJSON ');
            string jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            policyDetailGIData = new PolicyDetailGI();
            //customerInfoData = null;
            
            policyDetailGIJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status'); 
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    
                    /** Customer Profile **/
                    if (operation== 'Customer Profile'){
                        // note : for customer profile purpose
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        //policyDetailGIJSON = (string) packageData.get('jsonStr'); 
                        
                        try {
                            policyDetailGIData.No   =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::fullNM');
                            policyDetailGIData.Name =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::fullNM');
                            policyDetailGIData.FirstName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::firstNM');  
                            policyDetailGIData.MiddleName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::middleNM');
                            policyDetailGIData.LastName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::lastNM');
                            policyDetailGIData.Salutation =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::salutationTxt');
                            policyDetailGIData.Title =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::titleTXT');
                            policyDetailGIData.InsuredName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasDetailsOfRisksIn::hasPersonalDetailsIn::fullNM');
                            policyDetailGIData.CustomerID =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::individualUniqueID');
                            policyDetailGIData.CustomerPolicyNo =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::policyNO');
                            policyDetailGIData.Phone1 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::telephoneNO');
                            policyDetailGIData.Phone2 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::telephoneNO2');
                            policyDetailGIData.Mobile1 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::mobilePhoneNO');
                            policyDetailGIData.Mobile2 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::mobilePhoneNO2');
                            policyDetailGIData.Email1 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::emailAddress');
                            policyDetailGIData.Email2 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::emailAddress2');
                            policyDetailGIData.Fax1 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::faxNO');
                            policyDetailGIData.Fax2 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::faxNO2');
                            policyDetailGIData.ZipCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::postalCD');
                            policyDetailGIData.City =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::cityNM');
                            policyDetailGIData.InputerID =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::registeredBy');
                            policyDetailGIData.Address1 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::addressLine1');
                            policyDetailGIData.Address2 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::addressLine2');
                            policyDetailGIData.Address3 =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::addressLine3');
                            policyDetailGIData.Contact =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasRelationContact::fullNM');
                            policyDetailGIData.ContactAddress =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasRelationContact::hasAddressesIn::addressLine1');
                            policyDetailGIData.ContactPhone =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasRelationContact::hasAddressesIn::telephoneNO');
                            policyDetailGIData.Curr =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::currencyCD');
                            policyDetailGIData.MarketingOfficerName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeNM');
                            policyDetailGIData.MarketingOfficerCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeCD');
                            policyDetailGIData.MarketingOfficerDept =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeDept');
                            policyDetailGIData.TransactionTypeDescription =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasDetailsOfPolicyTransactionIn::transactionTypeDesc');
                            policyDetailGIData.IntermediaryTypeDescription =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasDetailsOfPolicyTransactionIn::intermediaryTypeDesc');
                            policyDetailGIData.CustomerTypeDescription =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::customerTypeCD');
                            policyDetailGIData.RelatedPolicy =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::relatedPolicyholdersCnt');
                            policyDetailGIData.Description =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::generalRk');
                            policyDetailGIData.Gender =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::genderCD');
                            policyDetailGIData.Married =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::maritalStatusCD');
                            policyDetailGIData.Country =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::countyNm');
                            policyDetailGIData.IDPassportNumber =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::passportNo');
                            policyDetailGIData.Nationality =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::nationalityCD');
                            policyDetailGIData.Occupation =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::occupation');
                            policyDetailGIData.Language =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::primaryLanguageCd');
                            policyDetailGIData.Birthdate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::birthDT'), 'yyyymmdd');
                            policyDetailGIData.Age = CCCUtils.birthToAge((Date) policyDetailGIData.Birthdate);     
                            policyDetailGIData.Birthplace =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::birthPlace');
                            policyDetailGIData.VIP =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::customerClassCD');
                            policyDetailGIData.AlternateAddress =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::canBeIndividual::hasAddressesIn::addressLine4');
                        } catch  (Exception e) { 
                            system.debug ('================ ERROR mapping (getGIPolicyDetail -  Customer Profile) : ' + e.getMessage());
                        }           
                    } 
                    
                    /** Policy Details **/
                    else if (operation== 'Policy Details'){
                        // note : for "Policy Detail" purpose
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        
                        try {
                            policyDetailGIData.PolicyNo = policyNo;
                            policyDetailGIData.PolicyHolder = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::relatedPolicyholdersCnt');
                            policyDetailGIData.ReferenceNo = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasDetailsOfPolicyTransactionIn::referenceNO');
                            policyDetailGIData.Insured = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasDetailsOfRisksIn::insuredID');
                            //policyDetailGIData.Description = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::');
                            policyDetailGIData.StartDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::issueDt'), 'yyyymmdd');
                            policyDetailGIData.EndDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyExpirationDTTM'), 'yyyymmdd');
                            policyDetailGIData.Premium = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::premiumAMT');
                            policyDetailGIData.PolicyDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyEffectiveDTTM'), 'yyyymmdd');
                            policyDetailGIData.ReferenceDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasDetailsOfPolicyTransactionIn::referenceDT'), 'yyyymmdd');
                            policyDetailGIData.CoverDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasDetailsOfPolicyTransactionIn::effectiveDTTM'), 'yyyymmdd');
                            policyDetailGIData.Segment = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policySegment');
                            policyDetailGIData.BranchName = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::issueBranchNM');
                            policyDetailGIData.BranchCode = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::issueBranchCD');
                            policyDetailGIData.StatusDescription = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::policyRK');
                            policyDetailGIData.TSI = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::isAssociatedWithGIInsuranceProduct::hasGIPolicySegmentDetailsIn::sumInsured');
                            policyDetailGIData.CertificateNo = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasGIPolicyEndorsementIn::certificateNo');
                            policyDetailGIData.Usage = CCCUtils.getStringDataOnMap(mapData,'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount[0]::hasAccountDetailsIn::usageCd');   
                            policyDetailGIData.MarketingOfficerName =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeNM');
                            policyDetailGIData.MarketingOfficerCode =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeCD');
                            policyDetailGIData.MarketingOfficerDept =  CCCUtils.getStringDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount::hasProducerInformationIn::gaOfficeDept');
                        } catch  (Exception e) { 
                            system.debug ('================ ERROR mapping (getGIPolicyDetail -  Policy Details) : ' + e.getMessage()); 
                        }
                    }
                } 
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (getGIPolicyDetail - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }                               
            }
        }
    }   

    public String TOCJSON{
        get {
            return TOCJSON;
        }
        set {
            system.debug('>>> on TOCJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            TOCList = new List<TableofContent>();
            //TOCList = null;
            
            TOCJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');  
                string operation = (string) packageData.get('operation');  
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                        
                        List <TableofContent> listTMP = new List <TableofContent>();
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo;
                                
                            TableofContent dataRec = new TableofContent();
                            
                            List<Object> objTOCList = (List<Object>) CCCUtils.getListDataOnMap(mapRec, 'hasDetailsOfGIRisksIn::coverageParam');
                            
                            Integer ind =0;
                            for (Object ooTOC : objTOCList) {
                                Map<String, Object> mapTOCRec = (Map<String, Object>) ooTOC;
                                
                                ind ++;
                                if (ind == 1 && dataRec.tableLabel1 !='') {dataRec.tableLabel1 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue1 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 2 && dataRec.tableLabel2 !='') {dataRec.tableLabel2 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue2 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 3 && dataRec.tableLabel3 !='') {dataRec.tableLabel3 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue3 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 4 && dataRec.tableLabel4 !='') {dataRec.tableLabel4 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue4 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 5 && dataRec.tableLabel5 !='') {dataRec.tableLabel5 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue5 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 6 && dataRec.tableLabel6 !='') {dataRec.tableLabel6 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue6 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 7 && dataRec.tableLabel7 !='') {dataRec.tableLabel7 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue7 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 8 && dataRec.tableLabel8 !='') {dataRec.tableLabel8 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue8 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 9 && dataRec.tableLabel9 !='') {dataRec.tableLabel9 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue9 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 10 && dataRec.tableLabel10 !='') {dataRec.tableLabel10 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue10 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 11 && dataRec.tableLabel11 !='') {dataRec.tableLabel11 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue11 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 12 && dataRec.tableLabel12 !='') {dataRec.tableLabel12 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue12 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 13 && dataRec.tableLabel13 !='') {dataRec.tableLabel13 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue13 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 14 && dataRec.tableLabel14 !='') {dataRec.tableLabel14 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue14 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                                else if (ind == 15 && dataRec.tableLabel15 !='') {dataRec.tableLabel15 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'name'); dataRec.tableValue15 = (string) CCCUtils.getStringDataOnMap(mapTOCRec, 'value');}
                            }
                            listTMP.add(dataRec);               
                        }
                        TOCList=listTMP;
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
                
            }
        }
    }
    
    public String accountDetailJSON{
        get {
            return accountDetailJSON;
        }
        set {
            system.debug('>>> on accountDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            accountDetailList =  new List<AccountDetail>();
            //accountDetailList = null;
            
            accountDetailJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');  
                string operation = (string) packageData.get('operation');  
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objHasPolicyAccountList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
                              
                        List <AccountDetail> accountDetailListTMP = new List <AccountDetail>();
                        
                        //system.debug ('objHasPolicyAccountList size : ' + objHasPolicyAccountList.size());
                        for (Object oo : objHasPolicyAccountList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            AccountDetail dataRec = new AccountDetail();

                            dataRec.AccountNo = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::accountNO');
                            dataRec.AccountName = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::payorFirstNM') + '  '  +
                                                    CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::payorLastNM'); 
                            dataRec.AccountEffectiveDate = CCCUtils.strToDate(CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::accountEffectiveDT'), 'yyyymmdd');
                            dataRec.AccountExpiredDate = CCCUtils.strToDate(CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::accountExpirationDT'),'yyyymmdd');
                            dataRec.AccountType = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::accountTypeCD');
                            dataRec.AccountStatus = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::accountStatusCD');
                            dataRec.CollectionBank = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::bankName');
                            dataRec.Branch = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::branchCD');
                            dataRec.RejectCode = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::rejectCD');
                            dataRec.RejectDate = CCCUtils.strToDate(CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::hasPartyAccountDetailsIn::rejectDT'), 'yyyymmdd');
                            
                            accountDetailListTMP.add(dataRec);              
                        }
                        
                        accountDetailList = accountDetailListTMP;
                        system.debug('====== value of accountDetailList : ' + accountDetailList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String agentInfoJSON {
        get{
            return null;
        }
        set{
            system.debug('>>> on agentInfoJSON  ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            agentInfoData = new agentInfo();
            //agentInfoData = null;
            
            agentInfoJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    mapData = (Map<String, Object>) packageData.get('mapData');
                    
                    try {
                        system.debug('== firstNM ' + CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::firstNM'));
                        system.debug('== middleNM ' + CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::middleNM'));
                        system.debug('== lastNM ' + CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::lastNM'));
                        
                        string firstNM= CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::firstNM'); 
                        string middleNM= CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::middleNM'); 
                        string lastNM= CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::lastNM'); 
                        
                        agentInfoData.AgentName = firstNM + ' ' + middleNM + ' ' +  lastNM; system.debug('====== SET TO        : AgentName ');
                        agentInfoData.AgentID = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::partyID'); system.debug('====== SET TO        : AgentID ');
                        agentInfoData.AgentNo = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::partyNO'); system.debug('====== SET TO        : AgentNo ');
                        agentInfoData.Entity = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeInternalOrg::orgShortNm'); system.debug('====== SET TO        : Entity ');
                        agentInfoData.Email = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::emailAddress'); system.debug('====== SET TO        : SourceCode ');
                        agentInfoData.Status = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::partyStatus'); system.debug('====== SET TO        : Status ');
                        agentInfoData.Area = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::branchCD'); system.debug('====== SET TO        : Area ');
                        agentInfoData.DistributionCode = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::distributionCD'); system.debug('====== SET TO        : DistributionCode ');
                        agentInfoData.DistributionType = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::distributionType'); system.debug('====== SET TO        : DistributionType ');
                        agentInfoData.Mobile = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::mobilePhoneNO'); system.debug('====== SET TO        : Mobile ');
                        agentInfoData.JoinDate =  CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::effectiveNominationDT'), 'yyyymmdd'); system.debug('====== SET TO        : JoinDate ');
                        //agentInfoData.TerminationDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::terminationDt'), 'yyyymmdd');
                        agentInfoData.HomePhone1 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::telephoneNO'); system.debug('====== SET TO        : HomePhone1 ');
                        agentInfoData.HomePhone2 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::telephoneNO2'); system.debug('====== SET TO        : HomePhone2 ');
                        agentInfoData.OfficePhone = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::officeTelNo'); system.debug('====== SET TO        : OfficePhone ');
                        agentInfoData.Address1 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::addressLine1'); system.debug('====== SET TO        : Address1 ');
                        agentInfoData.Address2 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::addressLine2'); system.debug('====== SET TO        : Address2 ');
                        agentInfoData.Address3 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::addressLine3'); system.debug('====== SET TO        : Address3 ');
                        agentInfoData.Address4 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::addressLine4'); system.debug('====== SET TO        : Address4 ');
                        agentInfoData.OfficeAddress1 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::officeAddressLine1'); system.debug('====== SET TO        : OfficeAddress1 ');
                        agentInfoData.OfficeAddress2 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::officeAddressLine2'); system.debug('====== SET TO        : OfficeAddress2 ');
                        agentInfoData.OfficeAddress3 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::officeAddressLine3'); system.debug('====== SET TO        : OfficeAddress3 ');
                        agentInfoData.OfficeAddress4 = CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn::canBeIndividual::hasAddressesIn::officeAddressLine4'); system.debug('====== SET TO        : OfficeAddress4 ');
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    //update Comment 
    /* public String agentReportingStructureHierarchyJSON {
        get {
            return agentReportingStructureHierarchyJSON;
        } 
        set {
            system.debug('>>> on agentReportingStructureHierarchyJSON ');
            string jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            agentReportingStructureHierarchyList = new List<AgentHierarchy>();
            //agentReportingStructureHierarchyList = null;
            
            agentReportingStructureHierarchyJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn');
                              
                        List <AgentHierarchy> listTMP = new List <AgentHierarchy>();
                        
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            AgentHierarchy dataRec = new AgentHierarchy();
                            dataRec.AgentName = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::firstNM') + ' '  +
                                                CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::middleNM') + ' ' + 
                                                CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::lastNM')  ;
                            dataRec.AgentCode = CCCUtils.getStringDataOnMap(mapRec, 'partyCD');
                            dataRec.PosCode = CCCUtils.getStringDataOnMap(mapRec, 'parentPartyCD');
                            dataRec.LeaderEffDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'effNominationDT'), 'yyyymmdd');
                            dataRec.Term = CCCUtils.getStringDataOnMap(mapRec, 'termRk');   
                                                    
                            listTMP.add(dataRec);               
                        }

                        agentReportingStructureHierarchyList = listTMP;
                        system.debug('====== value of agentReportingStructureHierarchyList : ' + agentReportingStructureHierarchyList);
                    }catch(Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }*/

    public String agentTopDownHierarchyJSON {
        get {return agentTopDownHierarchyJSON;} 
        set{
            system.debug('>>> on agentTopDownHierarchyJSON ');
            string jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            agentTopDownHierarchyList = new List<AgentHierarchy>();
            //agentTopDownHierarchyList = null;
            
            agentTopDownHierarchyJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPartyDetailsIn');
                              
                        List <AgentHierarchy> listTMP = new List <AgentHierarchy>();
                        
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            AgentHierarchy dataRec = new AgentHierarchy();
                            dataRec.AgentName = CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::firstNM') + ' '  +
                                CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::middleNM') + ' ' + 
                                CCCUtils.getStringDataOnMap(mapRec, 'canBeIndividual::lastNM')  ;
                            dataRec.AgentCode = CCCUtils.getStringDataOnMap(mapRec, 'partyCD');
                            dataRec.PosCode = CCCUtils.getStringDataOnMap(mapRec, 'parentPartyCD');
                            dataRec.LeaderEffDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'effNominationDT'), 'yyyymmdd');
                            dataRec.Term = CCCUtils.getStringDataOnMap(mapRec, 'termRk');   
                                                    
                            listTMP.add(dataRec);               
                        }
                        
                        agentTopDownHierarchyList = listTMP;
                        system.debug('====== value of agentTopDownHierarchyList : ' + agentTopDownHierarchyList);
                        
                    } catch (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                    system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                    //string errDescription = CCCUtils.getStringDataOnMap(mapData, 'Body::exception::message');  // << test for failed response
                    //system.debug('Webservice Error Response : ' + errDescription);
                    
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                }
            }
        }
    }   
    
    public String paymentHistoryLifeJSON{
        get{
            return paymentHistoryLifeJSON;
        }
        set{
            system.debug('>>> on paymentHistoryLifeJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            paymentHistoryLifeList = new List<PaymentHistoryLife>();
            //paymentHistoryLifeList = null;
            
            paymentHistoryLifeJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();    
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objHasLifePolicyTransactionDetailsIn  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasLifePolicyTransactionDetailsIn');
                              
                        List <PaymentHistoryLife> paymentHistoryLifeListTMP = new List <PaymentHistoryLife>();
                        
                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));
                        
                        system.debug('== paymentHistoryLifeLastPageNo 1 :' + paymentHistoryLifeLastPageNo );
                            
                        if (objHasLifePolicyTransactionDetailsIn.size() < numberOfRecords) { paymentHistoryLifeLastPageNo = pageNumber; system.debug('== paymentHistoryLifeLastPageNo 2 :' + paymentHistoryLifeLastPageNo ); }
                        
                        
                        //system.debug ('objHasLifePolicyTransactionDetailsIn size : ' + objHasLifePolicyTransactionDetailsIn.size());
                        for (Object oo : objHasLifePolicyTransactionDetailsIn) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            PaymentHistoryLife dataRec = new PaymentHistoryLife();
                            dataRec.PaymentMethod = CCCUtils.getStringDataOnMap(mapRec, 'paymentMethodCd');
                            dataRec.PaymentSubmissionDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'settledDT'), 'yyyymmdd');
                            dataRec.PaymentTransactionDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'transDT'), 'yyyymmdd');
                            dataRec.PaymentDueDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'paymentDueDT'), 'yyyymmdd');
                            dataRec.PaymentAmount = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'settledAMT'));
                            dataRec.PaymentType = CCCUtils.getStringDataOnMap(mapRec, 'paymentTypeCD'); 
                                                                    
                            paymentHistoryLifeListTMP.add(dataRec);             
                        }
                        
                        system.debug('== paymentHistoryLifeListTMP.size() : ' + paymentHistoryLifeListTMP.size() );
                        system.debug('== paymentHistoryLifeListTMP[0].PaymentMethod : ' + paymentHistoryLifeListTMP[0].PaymentMethod );
                        
                        if (paymentHistoryLifeListTMP.size()==1 && paymentHistoryLifeListTMP[0].PaymentMethod=='') {
                            
                            //if (pageNumber-1 < paymentHistoryLifeLastPageNo) { 
                                paymentHistoryLifeLastPageNo = pageNumber-1;
                                system.debug('== paymentHistoryLifeLastPageNo 3 :' + paymentHistoryLifeLastPageNo );
                            //}
                        }
                        paymentHistoryLifeList = paymentHistoryLifeListTMP;
                        system.debug('====== value of paymentHistoryLifeList : ' + paymentHistoryLifeList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }
    
    public String paymentHistoryGIJSON{
        get{
            return paymentHistoryGIJSON;
        }
        set{
            system.debug('>>> on paymentHistoryGIJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            paymentHistoryGIList = new List<PaymentHistoryGI>();
            //paymentHistoryGIList = null;
            
            paymentHistoryGIJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objHasLifePolicyTransactionDetailsIn  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasLifePolicyTransactionDetailsIn');
                              
                        List <PaymentHistoryGI> paymentHistoryGIListTMP = new List <PaymentHistoryGI>();
                        
                        //system.debug ('objHasLifePolicyTransactionDetailsIn size : ' + objHasLifePolicyTransactionDetailsIn.size());
                        for (Object oo : objHasLifePolicyTransactionDetailsIn) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            PaymentHistoryGI dataRec = new PaymentHistoryGI();

                            dataRec.PaymentMethod = CCCUtils.getStringDataOnMap(mapRec, 'paymentMethodCd'); 
                            dataRec.PaymentSubmissionDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'settledDT'), 'yyyymmdd');
                            dataRec.PaymentTransactionDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'transDT'), 'yyyymmdd');
                            dataRec.PaymentDueDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'paymentDueDT'), 'yyyymmdd');
                            dataRec.PaymentAmount = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'settledAMT'));
                            //dataRec.PaymentType = CCCUtils.getStringDataOnMap(mapRec, 'paymentTypeCD');   
                                                    
                            paymentHistoryGIListTMP.add(dataRec);               
                        }
                        
                        paymentHistoryGIList = paymentHistoryGIListTMP;
                        system.debug('====== value of paymentHistoryGIList : ' + paymentHistoryGIList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                }
                else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String fundHistoryJSON{
        get{
            return fundHistoryJSON;
        }
        set{
            system.debug('>>> on fundHistoryJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            fundHistoryList = new List<FundHistory>();
            //fundHistoryList = null;
            
            fundHistoryJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        //List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasAccountDetailsIn');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasLifePolicyTransactionDetailsIn');
                        
                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));
                        
                        if (objList.size() < numberOfRecords) { fundHistoryLastPageNo = pageNumber; }
                        system.debug('== fundHistoryLastPageNo :' + fundHistoryLastPageNo );
                              
                        List <FundHistory> fundHistoryListTMP = new List <FundHistory>();
                        
                        //system.debug ('objList size : ' + objList.size());
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            FundHistory dataRec = new FundHistory();
                            
                            //TODO : ambil dari objHasAccountDetailsIn
                            //dataRec.ULFundCode = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::investmentFundCd');
                            dataRec.ULFundCode = CCCUtils.getStringDataOnMap(mapRec, 'key');                  
                            dataRec.FundPriceDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'unitPriceAsOfDt'), 'yyyymmdd');
                            dataRec.UnitPrice = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'unitValue'));
                            dataRec.ULValuationDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'unitValuationDT'), 'yyyymmdd');
                            //dataRec.ULFundCodeRef = CCCUtils.getStringDataOnMap(mapRec, 'key');
                            dataRec.TransactionUnit  = CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'totalUnits'));
                            dataRec.TransactionAmount    = CCCUtils.strToDec(CCCUtils.getStringDataOnMap(mapRec, 'settledAMT'));
                            dataRec.TransactionDescription   = CCCUtils.getStringDataOnMap(mapRec, 'transDesc');
                            dataRec.TransactionDate  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'transDT'), 'yyyymmdd');
                            dataRec.TransactionEffectiveDate     = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'settledDT'), 'yyyymmdd');
                            dataRec.ProcessingType   = CCCUtils.getStringDataOnMap(mapRec, 'transTypeCD');
                            dataRec.ProcessingMode   = CCCUtils.getStringDataOnMap(mapRec, 'transModeCD');
                     
                            fundHistoryListTMP.add(dataRec);                
                        }

                        if (fundHistoryListTMP.size()==1 && fundHistoryListTMP[0].FundPriceDate==null) { fundHistoryLastPageNo = pageNumber-1; }
                        system.debug('== fundHistoryLastPageNo :' + fundHistoryLastPageNo );
                        
                        
                        fundHistoryList = fundHistoryListTMP;
                        system.debug('====== value of fundHistoryList : ' + fundHistoryList);

                        // set last date fund price date
                        Date fundHistoryLastDateTemp = fundHistoryList.get(fundHistoryListTMP.size()-1).FundPriceDate.addDays(0);
                        Datetime dtFundHistoryLastDate = datetime.newInstance(fundHistoryLastDateTemp.year(), fundHistoryLastDateTemp.month(),fundHistoryLastDateTemp.day());
                        fundHistoryLastDate = dtFundHistoryLastDate.format('yyyy-MM-dd');
                        system.debug('====== value of fundHistoryLastDate : ' + fundHistoryLastDate);
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }
    
    public String fundDetailJSON{
        get{
            return fundDetailJSON;
        }
        set{
            system.debug('>>> on fundDetailJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            fundDetailList = new List<FundDetail>();
            //fundDetailList = null;
            
            fundDetailJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
     
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasAccountDetailsIn');

                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));

                        if (objList.size() < numberOfRecords) { fundHistoryLastPageNo = pageNumber; }
                        system.debug('== fundDetailLastPageNo :' + fundDetailLastPageNo );
                        
                        List <FundDetail> fundDetailListTMP = new List <FundDetail>();
                        
                        //system.debug ('objList size : ' + objList.size());
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            FundDetail dataRec = new FundDetail();
                            
                            /*public class  FundDetail{
                                public string FundCode {get; set;}
                                public decimal FundAllocation {get; set;}
                                public decimal FundPrice {get; set;}
                                public decimal TotalUnitFund {get; set;}
                                public decimal TotalFundAmount {get; set;}
                                public date NAVDate {get; set;}
                                public decimal FundAmount {get; set;}
                                public string FundUnit {get; set;}
                                public decimal FundTotal {get; set;}
                                public date FundNAVDate {get; set;}

                                public FundDetail(){
                                }       
                            }*/
                            
                            dataRec.FundCode     = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::investmentFundCd');
                            dataRec.FundAllocation   = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::fundAllocation'));
                            dataRec.FundPrice    = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::unitPrice'));
                            dataRec.TotalUnitFund    = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::totalUnits'));
                            dataRec.TotalFundAmount  = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::totalFundAmount'));
                            dataRec.NAVDate  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::navDt'), 'yyyymmdd');   
                                            
                            fundDetailListTMP.add(dataRec);             
                        }

                        if (fundDetailListTMP.size()==1 && fundDetailListTMP[0].FundCode=='') { fundDetailLastPageNo = pageNumber-1; }
                        system.debug('== fundDetailLastPageNo :' + fundDetailLastPageNo );
                                                
                        fundDetailList = fundDetailListTMP;
                        system.debug('====== value of fundDetailList : ' + fundDetailList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
                
            }
        }
    }   
    
    public String fundPriceHistoryJSON{
        get{
            return null;
        }
        set{
            system.debug('>>> on fundPriceHistoryJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            fundPriceHistoryList = new List<FundPriceHistory>();
            //fundPriceHistoryList = null;
            
            fundPriceHistoryJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                system.debug('== size of packageData : ' + packageData.size());
                system.debug('== value of packageData : ' + packageData.values());
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
        
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        system.debug('== size of mapData : ' + mapData.size());
                        system.debug('== value of mapData : ' + mapData.values());

                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasAccountDetailsIn');

                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));

                        if (objList.size() < numberOfRecords) { fundPriceHistoryLastPageNo = pageNumber; }
                        system.debug('== fundPriceHistoryLastPageNo :' + fundPriceHistoryLastPageNo );
                              

                        List <FundPriceHistory> fundPriceHistoryListTMP = new List <FundPriceHistory>();
                        
                        //system.debug ('objHasInvestmentFundDetailsIn size : ' + objHasInvestmentFundDetailsIn.size());
                        system.debug('== size of objList : ' + objList.size());
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                            system.debug('== size of mapRec : ' + mapRec.size());
                            system.debug('== value of mapRec : ' + mapRec.values());
                                
                            FundPriceHistory dataRec = new FundPriceHistory();
    
                            dataRec.BidPrice_UnitPrice   = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::unitPrice'));
                            dataRec.OfferPrice_UnitPrice     = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::unitPriceAsOfDt'));
                            dataRec.ValuationDate    = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::saleEffectiveDt'), 'yyyymmdd');
                            dataRec.FundCurrency     = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::fundCurrencyCd');
                            dataRec.FundCode     = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::investmentFundCd');
                            dataRec.FundDescription  = CCCUtils.getStringDataOnMap(mapRec, 'hasInvestmentFundDetailsIn::investmentFundRk');
            
                            fundPriceHistoryListTMP.add(dataRec);               
                        }
                        
                        if (fundPriceHistoryListTMP.size()==1 && fundPriceHistoryListTMP[0].FundCode=='') { fundPriceHistoryLastPageNo = pageNumber-1; }

                        system.debug('== fundPriceHistoryLastPageNo :' + fundPriceHistoryLastPageNo );          
                        
                        fundPriceHistoryList = fundPriceHistoryListTMP;
                        system.debug('====== value of fundPriceHistoryList : ' + fundPriceHistoryList);
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }
    
    public String claimDetailLifeJSON{
        get{
            return claimDetailLifeJSON;
        }
        set{
            system.debug('>>> on claimDetailLifeJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            claimDetailLifeList = new List<claimDetailLife>();
            //claimDetailLifeList = null;
            
            claimDetailLifeJSON = jsonStr;
            if(jsonStr!=''){
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::IcAx_AXAAsiaCustomer_Type::hasPolicyAccount');
      
                        integer numberOfRecords = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::numberOfRecords'));
                        integer pageNumber = integer.valueOf(CCCUtils.getStringDataOnMap(mapData, 'Body::AXAAsiaPagination_Type::pageNumber'));
                        
                        system.debug('== claimDetailLifeLastPageNo 1 :' + claimDetailLifeLastPageNo );
                            
                        if (objList.size() < numberOfRecords) {
                            claimDetailLifeLastPageNo = pageNumber;
                            system.debug('== claimDetailLifeLastPageNo 2 :' + claimDetailLifeLastPageNo );
                        }
      
                        List <ClaimDetailLife> claimDetailLifeListTMP = new List <ClaimDetailLife>();
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                            List<Object> hasDetailsOfClaimIns = (List<Object>) CCCUtils.getListDataOnMap(mapRec, 'hasDetailsOfClaimIn');
                            List<Object> isAssociatedWithLifeInsuranceProducts = (List<Object>) CCCUtils.getListDataOnMap(mapRec, 'isAssociatedWithLifeInsuranceProduct');

                            for(Object hasDetailsOfClaimIn : hasDetailsOfClaimIns){
                                Map<String, Object> hasDetailsOfClaimInMap = (Map<String, Object>) hasDetailsOfClaimIn;
                                ClaimDetailLife dataRec = new ClaimDetailLife();

                                dataRec.ClaimNo  = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimReferenceID');
                                dataRec.ClaimType    = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimTypeCd');
                                //dataRec.ClaimPlan    = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimRk');
                                dataRec.ClaimSubmissionDate  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimOpenDTTM'), 'yyyymmdd');
                                dataRec.ClaimApprovalDate    = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimApprovalDTTM'), 'yyyymmdd');
                                dataRec.ClaimAmount  = CCCUtils.strToDec( CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimEndAMT') );
                                dataRec.ClaimStatus1     = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimStatusDesc');
                                dataRec.ClaimStatus2     = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimStatusRk');
                                dataRec.ClaimStatus  = CCCUtils.getStringDataOnMap(hasDetailsOfClaimInMap, 'claimStatusCD');                   
                
                                claimDetailLifeListTMP.add(dataRec);                
                            }
                            Integer keyClaimAssociated = 0;

                            for(Object isAssociatedWithLifeInsuranceProduct : isAssociatedWithLifeInsuranceProducts) {
                                Map<String, Object> isAssociatedWithLifeInsuranceProductMap = (Map<String, Object>) isAssociatedWithLifeInsuranceProduct;
                                
                                claimDetailLifeListTMP[keyClaimAssociated].ProductType = CCCUtils.getStringDataOnMap(isAssociatedWithLifeInsuranceProductMap, 'productTypeCD');
                                claimDetailLifeListTMP[keyClaimAssociated].ClaimPlan = CCCUtils.getStringDataOnMap(isAssociatedWithLifeInsuranceProductMap, 'planCd');

                                keyClaimAssociated++;
                            }
                        }
                        
                        claimDetailLifeList = claimDetailLifeListTMP;
                        system.debug('====== value of claimDetailLifeList : ' + claimDetailLifeList);
       
                        if (claimDetailLifeListTMP.size()==1 && claimDetailLifeListTMP[0].ClaimNo=='') {
                            claimDetailLifeLastPageNo = pageNumber-1;
                            system.debug('== claimDetailLifeLastPageNo 3 :' + claimDetailLifeLastPageNo );
                        }   
                        
                    } catch  (Exception e) { 
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                        
                        ClaimDetailLife dataRec = new ClaimDetailLife();
                        dataRec.ProductType  = 'data not available';
                        claimDetailLifeList.add(dataRec);
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                } else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
            }
        }
    }

    public String claimDetailGIJSON{
        get{
            return claimDetailGIJSON;
        }
        set{
            system.debug('>>> on claimDetailGIJSON ');
            String jsonStr = value.unescapeHtml4();
            system.debug('>>> ensure jsonStr : '+ jsonStr);
            
            claimDetailGIList2 = new List<ClaimDetailGI>();
            //claimDetailGIList = null;
            
            claimDetailGIJSON = jsonStr;
            if(jsonStr!='') {
                system.debug('>>> jsonStr : '+ jsonStr);

                Map<String, Object> packageData = new Map<String, Object>();
                packageData = CCCUtils.getMapPackageFromJSON(jsonStr);
                
                string status = (string) packageData.get('status');  
                string service = (string) packageData.get('service');
                string operation = (string) packageData.get('operation');               
                
                // Get Map Data
                Map<String, Object> mapData = new Map<String, Object>();
                
                if (status == '1') {
                    try {
                        mapData = (Map<String, Object>) packageData.get('mapData');
                        List<Object> objList  = (List<Object>) CCCUtils.getListDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::hasPnCClaimIn');

                        List <ClaimDetailGI> claimDetailGIListTMP = new List <ClaimDetailGI>();
                        
                        //system.debug ('objHasInvestmentFundDetailsIn size : ' + objHasInvestmentFundDetailsIn.size());
                        for (Object oo : objList) {
                            Map<String, Object> mapRec = (Map<String, Object>) oo; 
                                
                            ClaimDetailGI dataRec = new ClaimDetailGI();
                            dataRec.ClaimRegistrationNo = CCCUtils.getStringDataOnMap(mapRec, 'claimNumber');
                            dataRec.ClaimStatus = CCCUtils.getStringDataOnMap(mapRec, 'claimStatusDesc');
                            dataRec.BranchCode  = CCCUtils.getStringDataOnMap(mapRec, 'branchCode');
                            dataRec.ClientName  = CCCUtils.getStringDataOnMap(mapRec, 'hasClaimPartyRoles::canBeIndividual::firstNM') + ' ' +
                                    CCCUtils.getStringDataOnMap(mapRec, 'hasClaimPartyRoles::canBeIndividual::middleNM') + ' ' +
                                    CCCUtils.getStringDataOnMap(mapRec, 'hasClaimPartyRoles::canBeIndividual::lastNM') ;
                            
                            dataRec.NotificationDate    = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'notificationDate'), 'yyyymmdd');
                            dataRec.RegistrationDate    = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'claimOpenDate'), 'yyyymmdd');
                            dataRec.DateofLoss  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'lossDate'), 'yyyymmdd');
                            dataRec.Description = CCCUtils.getStringDataOnMap(mapRec, 'description');
                            dataRec.AccidentPlace   = CCCUtils.getStringDataOnMap(mapRec, 'hasMotorClaim::hasClaimAccidentDetails::accidentPlace');
                            dataRec.RepairShop  = CCCUtils.getStringDataOnMap(mapRec, 'hasMotorClaim::repairShop');
                            dataRec.ApprovalPaymentDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'approvalPaymentDate'), 'yyyymmdd');
                            dataRec.PaymentDate = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'claimPaymentDate'), 'yyyymmdd');
                            dataRec.DriverName  = CCCUtils.getStringDataOnMap(mapRec, 'hasMotorClaim::hasMotorClaimDriverDetails::canBeIndividual::firstNM') +  ' ' +
                                    CCCUtils.getStringDataOnMap(mapRec, 'hasMotorClaim::hasMotorClaimDriverDetails::canBeIndividual::middleNM')  +  ' ' +
                                    CCCUtils.getStringDataOnMap(mapRec, 'hasMotorClaim::hasMotorClaimDriverDetails::canBeIndividual::lastNM') ;
                            dataRec.BenefitOfType = CCCUtils.getStringDataOnMap(mapRec, 'coverageCode');
                            dataRec.DischargeDate  = CCCUtils.strToDate( CCCUtils.getStringDataOnMap(mapRec, 'dischargeDate'), 'yyyymmdd');

                            claimDetailGIListTMP.add(dataRec);              
                        }
                        
                        claimDetailGIList2 = claimDetailGIListTMP;
                        system.debug('====== value of claimDetailGIList2 : ' + claimDetailGIList2);
                        
                    } catch  (Exception e) {
                        system.debug ('================ ERROR mapping (' + service + ' - ' + operation + ')' + e.getMessage());
                    }
                }
                // :: if the response is failed
                else if (status == '-1') {
                    system.debug ('================ JSON is unrecognized (' + service + ' - ' + operation + ')');
                    system.debug ('================ DeserializeUntyped process get Error. jsonStr : ' + jsonStr);
                    ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                    ApexPages.addMessage(errMsg);
                    
                }
                else if (status == '0') {
                    //default - no result from json (maybe error)
                    string exceptionCode = (string) packageData.get('exceptionCode');
                    if (CCCUtils.isNoDataError(exceptionCode)) {
                        system.debug ('================ JSON status is 0 with Exception Code is ' + exceptionCode +  ' (No Data) - (' + service + ' - ' + operation + ')');
                    } else {
                        system.debug ('================ JSON Response is Failed (' + service + ' - ' + operation + ')');
                        system.debug ('================ Exception Message : ' + (string) packageData.get('exceptionMessage'));
                        ApexPages.Message errMsg = new ApexPages.Message(ApexPages.Severity.ERROR, operation + ' data cannot be retrieved. Please contact administrator.'); 
                        ApexPages.addMessage(errMsg);
                    }
                }
                
            }
        }
    }
    
    //--------------------        
    public void loadDataByInformationList(List<Data_Load_Sequence__c> infoList ){
        // here second
        List<Session_Data__c> sessionDataList = new List<Session_Data__c>();
        
        integer dataNo=0;
        system.debug ('============ Number of Data : ' + infoList.size() + ' items(s)');
        for(Integer i = 0; i < infoList.size(); i++){
            //Session_Data__c sessionData = new Session_Data__c();

            system.debug ('.');system.debug ('.');system.debug ('.');
            DateTime dtStart = DateTime.now();
            //system.debug ('============ ##### [' + infoList[i].Information__c + '] ');  //Request Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');

            dataNo  = i +1;
            system.debug ('######################################## DATA LOAD ########################################');
            system.debug ('================== Data No    : #' + dataNo );
            system.debug ('================== Session ID : ' + sessionID);
            system.debug ('================== Data Name  : ' + infoList[i].Information__c);
            
            if (infoList[i].SOURCE__C == 'Backend') {
                system.debug ('================== Service    : ' + infoList[i].SERVICE__C);
                system.debug ('================== Operation  : ' + infoList[i].OPERATION__C);
            }
            
            system.debug ('================== Entity     : ' + entity );
            system.debug ('================== App        : ' + policyApp );
            system.debug ('================== Starting   : ' + dtStart + ' ('+ dtStart.addHours(7)+')' );
            system.debug ('.');
            
            /*
            // new
            CCCRESTWebserviceConnectors.CustomerInfo objWSCustomerInfo = new CCCRESTWebserviceConnectors.CustomerInfo();
            Map<String, Object> packageData = new Map<String, Object>();
            
            // Get Package Data
            packageData = objWSCustomerInfo.getPackageData(policyNo, entity, 'Customer Profile', policyApp, '', '', 0, 0, 0, 0);    
            customerInfoDataReqPayloadJSON = objWSCustomerInfo.requestJSON  ; 
            customerInfoDataResPayloadJSON = (string) packageData.get('jsonStr');
            string status = (string) packageData.get('status');
            
            string jsonStr = getJSON(policyNo, entity, appID, operation, startDateTime, endDateTime, rowPerPage, startOfRecords, numberOfRecords, pageNumber);
            */
            
            String jsonStrRequest ='';
            String jsonStrRespond ='';
            String signatureData = '';
            String appID = policyApp;
            String startDateTime='';
            String endDateTime='';
            Integer rowPerPage=0;
            Integer startOfRecords=0;
            Integer numberOfRecords=0;
            Integer pageNumber=0;
            String operation = infoList[i].OPERATION__C;
            String service = infoList[i].SERVICE__C;
            String classType=''; 
            String refNo='';
            List<String> paramSignature = new List<String>();

            if (infoList[i].IsPaging__C == True || infoList[i].DataType__C=='LIST') {
                rowPerPage = integer.valueOf(infoList[i].RowPerPage__c);
                startOfRecords = 1;
                numberOfRecords  = rowPerPage;
                pageNumber =1;
            }

            try {
                if (service =='getCustomerInfo') { EIPJson eip = EIPConnector.getCustomerInfo(operation, entity, appID, policyNo, true); }
                else if (service =='getPolicyDetails') { EIPJson eip = EIPConnector.getPolicyDetails(operation, entity, appID, policyNo, true); }
                else if (service =='getGIPolicyDetail') { EIPJson eip = EIPConnector.getGIPolicyDetail(operation, entity, appID, policyNo, certificateNo, true); }
                else if (service =='getAgentInfo') { EIPJson eip = EIPConnector.getAgentInfo(operation, entity, appID, agentNo, null, true); }
                else if (service =='getBeneficiaryDetail') { EIPJson eip = EIPConnector.getBeneficiaryDetail(operation, entity, appID, policyNo, true); }
                else if (service =='getPremiumBreakdown') { EIPJson eip = EIPConnector.getPremiumBreakdown(operation, entity, appID, policyNo, true); }
                //else if (service =='getClaimDetails') { EIPJson eip = EIPConnector.getClaimDetails(operation, entity, appID, policyNo, true); }
                else if (service =='getGIClaimDetail') { EIPJson eip = EIPConnector.getGIClaimDetail(operation, entity, appID, policyNo/*, true*/); }
                else if (service =='getPaymentHistory') { EIPJson eip = EIPConnector.getPaymentHistory(operation, entity, appID, policyNo, true); }
                else if (service =='getFundHistory') { EIPJson eip = EIPConnector.getFundHistory(operation, entity, appID, policyNo, startDateTime, endDateTime); }
                else if (service =='getFundDetail') { EIPJson eip = EIPConnector.getFundDetail(operation, entity, appID, policyNo, true); }
                else if (service =='getAssNotes'){
                    classType = infoList[i].CLASSTYPE__C;
                    EIPJson eip = EIPConnector.getAssNotes(operation, entity, appID, policyNo, classType, refNo, null, true); } 
                else if (service =='getProductFundDetail'){ }
                signatureData = EIPConnector.getSignature();
                jsonStrRequest = EIPConnector.getRequestPrettyPrint();
                jsonStrRespond = EIPConnector.getResponsePrettyPrint();
                // dicomment karena kalau ada exception di EIP Connector, debug dibawah tidak terdebug
                // System.debug('[EIP] JSON REQUEST : '+jsonStrRequest);
                // System.debug('[EIP] JSON RESPONSE : '+jsonStrRespond);
                if(jsonStrRespond != null || jsonStrRequest != null){
                    sessionDataList = CCCUtils.addSessionDataToList(
                        sessionDataList, sessionID, infoList[i].service__c, infoList[i].operation__c, infoList[i].CLASSTYPE__c, 
                        refNo, infoList[i].Information__c, infoList[i].Information__c, infoList[i].ENTITY__C, infoList[i].PAGE_NAME__C, 
                        infoList[i].Sequence__c, integer.valueof(infoList[i].ORDER__c), string.valueOf(pageNumber), 
                        jsonStrRespond, jsonStrRequest, signatureData);
                }
            }catch(EIPConnector.NoDataException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'no data for this response.'));
            }catch(EIPConnector.EIPConnectorException e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            }

            // insert into session data object
            /*sample
            List<AppLog__c> logList = new List<AppLog__c>(); 
            AppLog__c applogWs = new AppLog__c();
            applogWS.Policy_App__c = contactRec.PolicyApp__c;
            logList.add(applogws);
            insert logList;
            */
            
            //if (infoList[i].ExtraLoad__C== null || infoList[i].ExtraLoad__C < 1) {
                //system.debug ('================== Data       : ' + jsonStrRespond);
                //system.debug ('---------------------------------------------------------------------------------------------------------------------------------------------');
            //}
            
            DateTime dtEnd = DateTime.now();
            long d =  dtEnd.getTime() - dtStart.getTime() ;
            
            system.debug ('.');
            system.debug ('************ DATA LOAD ITEM REPORT (' + infoList[i].SOURCE__C + ')  ************');
            system.debug ('============ Data No             : #' + dataNo );
            system.debug ('============ Session ID          : ' + sessionID);
            system.debug ('============ Entity              : ' + Entity);
            system.debug ('============ Policy App          : ' + policyApp);
            
            system.debug ('============ Data Name           : ' + infoList[i].Information__c);
            
            if (infoList[i].SOURCE__C == 'Backend') {
                system.debug ('============ Service             : ' + infoList[i].SERVICE__C);
                system.debug ('============ Operation           : ' + infoList[i].OPERATION__C);
            }
            system.debug ('============ Starting at         : ' + dtStart + ' ('+ dtStart.addHours(7) +')' );
            system.debug ('============ End at              : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')' );
            system.debug ('============ Data Load Duration  : ' + d + ' milliseconds' );
            
            system.debug ('.');
            system.debug ('.');
        }
        System.debug('==== sessionID ==== '+sessionID);
        System.debug('==== INSERT sessionDataList === '+sessionDataList);
            
        //insert sessionDataList;

        if(sessionDataList.size() > 0 && sessionDataList != null){insert sessionDataList;} 
        else { system.debug('There are not sessionDataList');  }
            
        /*    
        try{
            insert sessionDataList;    
        }catch(DmlException e){
            //--Added by Suryono 8/8/2019
            System.debug('Error DML Session Data : ' + e);
            //getClaimListFromConnector(); //probably need to create flag if error/not
            flagClaim = true;
        } catch (Exception e) {
            System.debug('Unexpected Error : ' + e);
        }*/
            
        //return sessionDataList;
    }
    
        
    public void loadDataBySequenceNo (string sequenceNo, string source){
        // here first
        DateTime dtStart = DateTime.now();

        List<Data_Load_Sequence__c> dataLoadSequenceList = null;
        
        if (source=='Backend') {
            if (PolicyApp=='BIS') dataLoadSequenceList =[Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,   IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and BIS__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];   
            else if (PolicyApp=='BIS') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C, IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and BIS__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='Clipper') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C, IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and Clipper__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='RLS') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C, IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and RLS__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='DMTM') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and DMTM__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='CARE') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and CARE__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='PSEA') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and PSEA__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
            else if (PolicyApp=='G400') dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and G400__C=true and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ];
        } else if (source=='SFDC') { dataLoadSequenceList = [Select entity__c, Information__c, Service__c, Operation__c, Section__c, Source__c, IsDisplay__c, Sequence__c, PAGE_NAME__c, CLASSTYPE__c, ORDER__c, DataType__C,    IsPaging__C,    RowPerPage__c,  ExtraLoad__C   FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and isDisplay__c = true and sequence__c =: sequenceNo order by ORDER__c ]; }
        
        if (dataLoadSequenceList != null) {
            system.debug ('================== @@@@@ DATA LOAD SEQUENCE NO : #' + sequenceNo + ' @@@@@ ==================');
            system.debug ('============ Entity      : ' + entity);
            system.debug ('============ Policy App  : ' + policyApp);
            system.debug ('============ Sequence No : #' + sequenceNo);
            system.debug ('============ Source      : ' + source);
            system.debug ('============ Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
            system.debug ('--------------------------------------------------------------------------------------------');
            system.debug ('.');
            
            loadDataByInformationList (dataLoadSequenceList);
            
            DateTime dtEnd = DateTime.now();
            long d =  dtEnd.getTime() - dtStart.getTime() ;
            
            system.debug ('.');
            system.debug ('************ DATA LOAD SEQUENCE REPORT ************');
            system.debug ('============ Sequence No            : #' + sequenceNo);
            system.debug ('============ Entity                 : ' + entity);
            system.debug ('============ Policy App             : ' + policyApp);        
            system.debug ('============ Source                 : ' + source);
            
            if (source=='Backend') {
                system.debug ('============ Total Call Service     : ' + dataLoadSequenceList.size() + ' service(s)');
            } else if (source=='SFDC') {
                system.debug ('============ Total Data Item     : ' + dataLoadSequenceList.size());
            }
            
            system.debug ('============ Starting at            : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
            system.debug ('============ End at                 : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
            system.debug ('============ Total Duration         : ' + d + ' milliseconds'); 
            system.debug ('======== *** Data Load is Done *** ==================================================================================================');
            system.debug ('-------------------------------------------------------------------------------------------------------------------------------------');
            system.debug ('.');
            system.debug ('.');
        }
    }    
    
    /**
    *    INIT DATA
    */
    public Contact[] getContacts() {
        return [
                select FirstName, LastName, Birthdate, Email, LastModifiedDate, OwnerId
                from Contact
                order by Name
                limit 500
                ];
    }
    
    public void loadDataSeq2and3() {
        system.debug('=========== enter in method : loadDataSeq2and3()');
        /* Data load #2 */
        loadDataBySequenceNo('2', 'Backend') ;
        /* Data load #3 */
        loadDataBySequenceNo('3', 'Backend') ;
    }

    public void loadDataSeq2() {
        system.debug('=========== enter in method : loadDataSeq2()');
        /* Data load #2 */
        loadDataBySequenceNo('2', 'Backend') ;
    }

    public void loadDataSeq3() {
        system.debug('=========== enter in method : loadDataSeq3()');
        /* Data load #2 */
        loadDataBySequenceNo('3', 'Backend') ;
    }   
    
    public void onloadCustomerProfile () {
        system.debug('=========== enter in method : onloadCustomerProfile()');
        /* Data load #2 */
        loadDataBySequenceNo('2', 'Backend') ;
        /* Data load #3 */
        loadDataBySequenceNo('3', 'Backend') ;
    }
    
    public void initMain(){ 
        List<AppLog__c> logList = new List<AppLog__c>();        
        AppLog__c applogWs = new AppLog__c();
        AppLog__c applogScreen = new AppLog__c();
        applogScreen.id__c = contactId;
        applogScreen.method__c = 'load police detatil screen ';
        //applogScreen.start_date__c = system.now();
        applogScreen.StartLongTime__c = system.now().getTime();
    
        //List<Contact> contactList = [SELECT Id, Policy_No__c, Entity__c, PolicyApp__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
        List<Contact> contactList = [SELECT Id, name, Policy_No__c, Policy_No_AGI__c, Entity__c, PolicyApp__c, Certificate_No__c, Phone, MobilePhone, HomePhone, Policy_Status__c, Policy_Effective_Date__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Premium__c, Segment_Name__c, Branch_Name__c, Branch_Code__c, Date_of_Accident__c, Driver__c, Accident_Place__c, Detail_of_Damage__c, Production_Year__c, Licence_Number__c, Machine_No__c, Chassis_no__c, Vehicle_Type__c, Color__c, Machine_Capacity__c, Agent_Profile_No__c FROM Contact WHERE ID =: contactId];      
        system.debug('contactList: ' +contactList);
        Contact contactRec = null;
        
        if(contactList.size()>0){
            contactRec = contactList[0];
            policyNo = contactRec.Policy_No_AGI__c;  
            contactName = contactRec.name;
            certificateNo = contactRec.Certificate_No__c; 
            entity = contactRec.Entity__c;
            policyApp = contactRec.PolicyApp__c;
            
            system.debug (' *** policyNo      : ' + policyNo );
            system.debug (' *** contactName   : ' + contactName );
            system.debug (' *** certificateNo : ' + certificateNo );
            system.debug (' *** entity        : ' + entity );
            system.debug (' *** policyApp     : ' + policyApp );
            
            /*
            //CCCWebserviceConnectors.ArrayOfGetPolicyDetailsClipper ambil = srv.GetPolicyDetailsSFDC(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, '');
            applogWs.id__c = contactId;
            //applogWs.method__c = 'call webservice : CCCWebserviceConnectors10.iServiceSoap()';
            //applogWs.start_date__c = system.now();
            applogWS.StartLongTime__c = system.now().getTime();
            CCCWebserviceConnectors10.iServiceSoap srv = new CCCWebserviceConnectors10.iServiceSoap();
            CreateToken ct = new CreateToken();
            token = ct.getToken();
            */
         
            if (entity=='AMFS') { isDisplayAMFS = true; isDisplayAFI = false; isDisplayMAGI = false; isDisplayAFI_AMFS = true; isDisplayAMFS_MAGI = true; isDisplayAFI_MAGI = false; isDisplayAFI_AMFS_MAGI = true; }
            else if (entity=='AFI') { isDisplayAMFS = false; isDisplayAFI = true; isDisplayMAGI = false; isDisplayAFI_AMFS = true; isDisplayAMFS_MAGI = false; isDisplayAFI_MAGI = true; isDisplayAFI_AMFS_MAGI = true; }
            else if (entity=='MAGI') { isDisplayAMFS = false; isDisplayAFI = false; isDisplayMAGI = true; isDisplayAFI_AMFS = false; isDisplayAMFS_MAGI = true; isDisplayAFI_MAGI = true; isDisplayAFI_AMFS_MAGI = true; }
            else if (entity=='AGI') { isDisplayAMFS = false; isDisplayAFI = false; isDisplayMAGI = false; isDisplayAGI = true; isDisplayAFI_AMFS = false; isDisplayAMFS_MAGI = false; isDisplayAFI_MAGI = false; isDisplayAFI_AGI = true; isDisplayAMFS_AGI = true; isDisplayMAGI_AGI = true; isDisplayAFI_AMFS_MAGI = false; isDisplayAFI_AMFS_AGI = true; isDisplayAFI_AGI_MAGI = true; isDisplayAGI_AMFS_MAGI = true; isDisplayAFI_AMFS_MAGI_AGI = true; }
            
            if (contactRec.Agent_Profile_No__c != null || contactRec.Agent_Profile_No__c == '') { isAgentProfile = true; isCustomerProfile = false; agentNo = contactRec.Agent_Profile_No__c; }
            else { isAgentProfile = false; isCustomerProfile = true; }
        }
    }

    public void setJSONVariable (string code, string value) {
        system.debug('----- mapping for  : ' + code);
        system.debug('----- value        : ' + value);
        
        
        if (value!= null) {
            // :: getCustomerInfo
            if (code == 'getCustomerInfo::Customer Profile') { customerInfoJSON = value; }
            else if (code == 'getCustomerInfo::Account Detail') { accountDetailJSON = value; }
            
            // :: getPolicyDetail
            else if (code == 'getPolicyDetails::Insured Details') { insuredDetailLifeJSON = value; }
            else if (code == 'getPolicyDetails::Policy Details') { policyDetailLifeJSON = value; }
            else if (code == 'getPolicyDetails::Policy Change') { policyChangeLifeJSON = value; }
            else if (code == 'getPolicyDetails::Cash Value') { cashValueDetailJSON = value; }
            
            // :: getGIPolicyDetail
            else if (code == 'getGIPolicyDetail::Customer Profile') { policyDetailGIJSON = value; }
            else if (code == 'getGIPolicyDetail::Policy Details') { policyDetailGIJSON = value; }
            else if (code == 'getGIPolicyDetail::Insured Details') { TOCJSON = value; }
            else if (code == 'getGIPolicyDetail::Policy Change') { endorsementGIJSON = value; }
            else if (code == 'getGIPolicyDetail::Risk Info') { riskInfoJSON = value; }
            //else if (code == 'getGIPolicyDetail::Risk Detail') { riskInfoJSON = value; }
            else if (code == 'getGIPolicyDetail::Own Risk') { ownRiskJSON = value; }
            else if (code == 'getGIPolicyDetail::Interest Info') { interestInfoJSON = value; }
            
            // :: getAgentInfo  -- cek ada topdown dan reporting
            else if (code == 'getAgentInfo::Agent Info') { agentInfoJSON = value; }
            else if (code == 'getAgentInfo::Agent Hierarchy') { agentTopDownHierarchyJSON = value; }
            
            // :: getBeneficiaryDetail
            else if (code == 'getBeneficiaryDetail::Beneficiary') { beneficiaryDetailJSON = value; }
            
            // :: getBenefitDetail
            else if (code == 'getPremiumBreakdown::Benefit Detail') { benefitDetailJSON = value; }
            
            // :: getPremiumBreakdown
            else if (code == 'getPremiumBreakdown::Premium Breakdown') { premiumBreakdownJSON = value; }
            
            // :: getClaimDetail
            else if (code == 'getClaimDetails::Claim') { claimDetailLifeJSON  = value; }
            
            // :: getGIClaimDetail
            else if (code == 'getGIClaimDetail::Claim') { claimDetailGIJSON = value; }
            
            // :: getPaymentHistory
            else if (code == 'getPaymentHistory::Payment') { paymentHistoryLifeJSON = value; }
            
            // :: getFundHistory
            else if (code == 'getFundHistory::Fund') { fundHistoryJSON = value; }
            
            // :: getFundDetail
            else if (code == 'getFundDetail::Fund') { fundDetailJSON = value; }
            
            // :: getProductFundDetail
            else if (code == 'getProductFundDetail::Fund') { fundPriceHistoryJSON = value; }
    
            // :: getAssNotes
            else if (code == 'getAssNotes::Summary') { assNotesJSON = value; }
            else if (code == 'getAssNotes::Detail') { assNotesJSON = value; }
        }
    }

    /*public void preparingPageDataTEST (string sessionID, string pageName) {
        
        List<Session_data__c> sessionDataList = [select data_name__c, service__c, operation__c, data__c, data_request__c from session_data__c where session_id__c=:sessionID and page_name__c=:pageName order by  sequenceNo__c , order__C] ;
        Session_data__c sessionDataRec = null;
        List<Data_Load_Sequence__c> dataLoadSequenceList = null;
        
        string source='Backend'; // SAMPAI SINI!!!!

        if (source=='Backend') {
            if (PolicyApp=='BIS') dataLoadSequenceList =[Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and BIS__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];   
            else if (PolicyApp=='Clipper') dataLoadSequenceList = [Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and Clipper__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];
            else if (PolicyApp=='RLS') dataLoadSequenceList = [Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and RLS__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];
            else if (PolicyApp=='DMTM') dataLoadSequenceList = [Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and DMTM__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];
            else if (PolicyApp=='CARE') dataLoadSequenceList = [Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and CARE__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];
            else if (PolicyApp=='PSEA') dataLoadSequenceList = [Select Service__c, Operation__c, ClassType__c FROM Data_Load_Sequence__c where source__c=:source and entity__c =: entity and PSEA__C=true and isDisplay__c = true and PAGE_NAME__C=:pageName order by SEQUENCE__C, ORDER__c ];
        }

        if (dataLoadSequenceList != null) {
            for(Integer i = 0; i < dataLoadSequenceList.size(); i++){
                
                //dataLoadSequenceList[i].Service__c
                
            }
            
        }           
    }*/
    
    public void preparingPageDataCallFromPage() {
        system.debug ('=');
        system.debug ('======= *** REQUEST FOR PREPARING PAGE DATA FROM PAGE *** ======');
        system.debug ('=');
        
        String sessionID = ApexPages.CurrentPage().getParameters().get('sessionID');
        String pageName = ApexPages.CurrentPage().getParameters().get('pageName');
        
        preparingPageData(sessionID, pageName);
    }

    public void preparingPageData (string sessionID, string pageName) {
        /* ----------------------------------- */
        /* Load Data for page                  */
        /* ----------------------------------- */
        system.debug ('.'); system.debug ('.');
        system.debug ('======= *** PREPARING OF PAGE DATA *** ==========================================================================================================');
        system.debug ('=========== Page    : ' + pageName);
        system.debug ('=========== Session : ' + sessionID);
        
        DateTime dtStart = DateTime.now();
        system.debug ('=========== Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        
        
        //string pageName='PolicyInfoPage';
        List<Session_data__c> sessionDataList = [select data_name__c, service__c, operation__c, classType__c, refNo__c, data__c, data_request__c from session_data__c where session_id__c=:sessionID and page_name__c=:pageName order by  sequenceNo__c , order__C] ;
        Session_data__c sessionDataRec = null;
        // select data_name, data from session_data__c where session_id__c='userid-customerid-20170106-abcde12345' and data_name__c='Policy Details' and page_name__c='PolicyInfoPage';
        integer dataNo=0;
        if(sessionDataList.size()>0){
            for(Integer i = 0; i < sessionDataList.size(); i++){  
                sessionDataRec = sessionDataList[i];
                
                dataNo=i+1;
                system.debug ('.'); 
                system.debug('== :: DATA NO      : #' + dataNo + ' << ');
                system.debug('== :: SERVICE      : ' + sessionDataRec.service__c);
                system.debug('== :: OPERATION    : ' + sessionDataRec.operation__c);
                
                if(sessionDataRec.service__c=='getAssNotes') {
                    system.debug('== :: CLASS TYPE   : ' + sessionDataRec.classType__c);
                    if(sessionDataRec.operation__c=='Detail') {
                        system.debug('== :: REFNO    : ' + sessionDataRec.refNo__c);
                    }
                }
                
                system.debug('== :: Entity       : ' + entity);
                system.debug('== :: App          : ' + policyApp);
                system.debug('== :: JSON Request : ' + sessionDataRec.data_request__c);
                
                // taufik 2019, testing 1 Operation.
                //if (sessionDataRec.operation__c == 'Benefit Detail')
                    setJSONVariable(sessionDataRec.service__c +'::'+sessionDataRec.operation__c, sessionDataRec.data__c );                    
            }           
        } else {
            flagClaim = true; //Added by Suryono 9/8/2019
        }
        
        system.debug ('.');system.debug ('.');system.debug ('.');
        system.debug ('=========== Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        DateTime dtEnd = DateTime.now();
        system.debug ('=========== Finish at   : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        system.debug ('=========== Duration    : ' + d + ' milliseconds'); 
        system.debug ('======= *** Preparing of Page data is Done *** ==================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
        system.debug ('.');
    }
    
    public void preparingPageDataSFDC (string sessionID, string pageName) {
        /* ----------------------------------- */
        /* Load Data for page                  */
        /* ----------------------------------- */
        system.debug ('.'); system.debug ('.');
        system.debug ('======= *** PREPARING OF PAGE DATA *** ==========================================================================================================');
        system.debug ('=========== Page    : ' + pageName);
        system.debug ('=========== Session : ' + sessionID);
        
        if (pageName=='RHSInfoPage'){ RHSList = [select CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name, CreatedByName__c from Case where type='Request' and Policy_Numbers__c =:policyNo order by  CreatedDate desc] ; }
        else if (pageName=='CHSInfoPage'){ CHSList = [select CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name, CreatedByName__C from Case where type='Complaint' and Policy_Numbers__c =:policyNo  order by  CreatedDate desc] ; }
        else  if (pageName=='InquiryInfoPage'){ InquiryList = [select CaseNumber, Type, Subject, CreatedDate, Status, Owner.Name, CreatedByName__c from Case where type='Inquiry' and Policy_Numbers__c =:policyNo  order by  CreatedDate desc] ; }
    }
        
    public void initContactProfile () {
        
        DateTime dtStart = DateTime.now();
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== CONTACT PROFILE PAGE =========== ');
        system.debug ('>>> initContactProfile is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID ); 
        
        /* load data for sequence number 1 */
        //loadDataBySequenceNo('0', 'Backend') ;
        loadDataBySequenceNo('1', 'Backend') ;
        loadDataBySequenceNo('1', 'SFDC') ;
        preparingPageData(sessionID, 'ContactProfilePage');
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        
        system.debug ('=========== CONTACT PROFILE PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
        
    }
    
    public void initPolicyInfo () {
        
        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initPolicyInfo is begin ..');
        initMain();
        assessmentNotesSummaryUWLastPageNo = 0;
        assessmentNotesSummaryPALastPageNo = 0;
        assessmentNotesSummaryPOSLastPageNo = 0;
        assessmentNotesSummaryOTHLastPageNo = 0;
        
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'PolicyInfoPage');
        //getEIPPremiumBreakdownList(); //--Added by Daniel 10/8/2019
        //getEIPCustomerInfoList();
        //getEIPPolicyDetailList();
        getEIPPolicyChangeList();
        getEIPPremiumBreakdownList();
        getEIPRiskDetailList();
        getEIPBenefitDetailList(); //--Added by Suryono 10/8/2019
        getInsuredDetailList();
        
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

    public void initPaymentInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initPaymentInfo is begin ..');
        initMain();
        paymentHistoryLifeLastPageNo=0;
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'PaymentInfoPage');
        
        // get Row Per Page
        paymentHistoryLifeRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Payment History', 'PaymentInfoPage');
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== PAYMENT INFO PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');  
    }
        
    public void initFundInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initFundInfo is begin ..');
        initMain();
        fundHistoryLastPageNo = 0;
        fundDetailLastPageNo = 0;
        fundPriceHistoryLastPageNo = 0;
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'FundInfoPage');
        
        // get Row Per Page
        fundHistoryRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund History', 'FundInfoPage');
        fundDetailRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund Details', 'FundInfoPage');
        fundPriceHistoryRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Fund Price History', 'FundInfoPage');
        //fundHistoryLastDate = Date.today();
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== FUND INFO PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');                   
    }

    public void initClaimInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initClaimInfo is begin ..');
        initMain();
        getEIPClaimDetailList();
        assessmentNotesSummaryCLMLastPageNo = 0;
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'ClaimInfoPage');
        if(flagClaim == true) {
            getClaimListFromConnector(); // Added by Suryono 8/8/2019
        }
        // get Row Per Page
        claimDetailLifeRowPerPage = CCCUtils.getRowPerPage('Backend', entity, PolicyApp, 'Claims History', 'ClaimInfoPage');
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== CLAIM INFO PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');  
    }
    
    public void initRHSInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initRHSInfo is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageDataSFDC(sessionID, 'RHSInfoPage');
        //
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== RHS INFO PAGE ================== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');    
    }   

    public void initCHSInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initRHSInfo is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageDataSFDC(sessionID, 'CHSInfoPage');
        //
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== CHS INFO PAGE ================== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');  
    }
    
    public void initInquiryInfo () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initRHSInfo is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageDataSFDC(sessionID, 'InquiryInfoPage');
        //
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== INQUIRY INFO PAGE ============== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
    }

    public void initAssessmentNotesDetail () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initAssessmentNotesDetail is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID );
        preparingPageData(sessionID, 'AssessmentNotesDetailPage');
        //
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== ASESSMENT NOTES DETAIL PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------');
    }
    
    public void initAgentProfile () {

        DateTime dtStart = DateTime.now();
        
        //
        system.debug ('>>> initAgentProfile is begin ..');
        initMain();
        
        system.debug ('>>> sessionID : ' + sessionID );
        // loadDataWSTopDownHierarchy();     ????
        loadDataBySequenceNo('0', 'Backend') ;
        preparingPageData(sessionID, 'AgentProfilePage');
        //
        
        DateTime dtEnd = DateTime.now();
        long d =  dtEnd.getTime() - dtStart.getTime() ;
        
        system.debug ('.');system.debug ('.');
        system.debug ('=========== PAGE LOAD ====================== ');
        system.debug ('=========== AGENT PROFILE PAGE =========== ');
        system.debug ('=========== Page Initiation Starting at : ' + dtStart + ' ('+ dtStart.addHours(7) +')');
        system.debug ('=========== Page Ready at               : ' + dtEnd + ' ('+ dtEnd.addHours(7) +')');
        system.debug ('=========== Total Duration              : ' + d + ' milliseconds'); 
        system.debug ('======= *** Page is already *** ==============================================================================================================');
        system.debug ('----------------------------------------------------------------------------------------------------------------------------------------------'); 
    }  
            
    public void loadDataWSTopDownHierarchy () {
        CCCRESTWebserviceConnectors rwsc = new CCCRESTWebserviceConnectors();
        
        //justfor test
        string policyNoTEMP = '100-103-0000038';
        
        system.debug('================== loadDataWSTopDownHierarchy ( GetAgentInfo - Top Down Hierarchy ) ==================');
        DateTime dtStart = DateTime.now();
        system.debug ('================== DATA LOAD STARTING AT : ' + dtStart);
        
        CCCRESTWebserviceConnectors.AgentInfo objWSAgentInfo = new CCCRESTWebserviceConnectors.AgentInfo();
        Map<String, Object> packageData = new Map<String, Object>();
        
        // Get Package Data
        /* param : string policyNo, string entity, string operation, string appID, string startDateTime, string endDateTime, 
                Integer rowPerPage, Integer startOfRecords,
                Integer numberOfRecords, Integer pageNumber */
        packageData = objWSAgentInfo.getPackageData(agentNo, entity, 'Top Down Hierarchy', policyApp, '', '', 0, 0, 0, 0);  
        
        string requestJSON= objWSAgentInfo.requestJSON;
        system.debug ('|============ Req Body : '+ requestJSON );
        agentTopDownHierarchyListReqPayloadJSON = 'Request | Start:' + dtStart + ' | jsonReq:' + requestJSON;
        
        // get data
        agentTopDownHierarchyJSON =  (string) packageData.get('jsonStr');
        
        DateTime dtEnd = DateTime.now();
        agentTopDownHierarchyListResPayloadJSON = 'Respond | End:' + dtEnd + ' | jsonRes:' + agentTopDownHierarchyJSON;
        
        system.debug ('================== DATA LOAD END AT : ' + dtEnd);
    }
    
    /** CONSTRUCTOR for ApexPages.StandardController
    */
    public PolicyInfoAGIController(ApexPages.StandardController controller) {
        flagClaim = false; //--Added by Suryono 8/8/2019
        
        AssNotesDetailJSON assNotesDetail = new AssNotesDetailJSON ();
        
        
        //pelanggan = new Customer();    
        customerInfoData = new CustomerInfo();   
        //accountInfoData = new AccountInfo();
        policyDetailLifeData = new PolicyDetailLife();
        policyDetailGIData = new PolicyDetailGI();
        
        agentInfoData = new AgentInfo();
        agentReportingStructureHierarchyList = new List<AgentHierarchy>();
        agentTopDownHierarchyList = new List<AgentHierarchy>();
        
        insuredDetailLifeList = new List<InsuredDetailLife>();
        
        paymentHistoryLifeList = new List<paymentHistoryLife>();
        paymentHistoryGIList = new List<paymentHistoryGI>();
         
        
        agen = new Agent();
        polisRider = new PolicyRider(); 
        detailFund = new DetailFund();
        insuredList = new List<Insured>(); 
        beneficiaryDetailList = new List<BeneficiaryDetail>();
        policyDetailList = new List<PolicyDetailGI>();
        riskDetailList = new List<RiskDetail>();
        benefitDetailList = new List<BenefitDetail>();
        trxPaymentList = new List<TrxPayment>();
        trxClaimList = new List<TrxClaim>();
        detailFundList = new List<DetailFund>();
        fundTrxList = new List<FundTransaction>();
        //cashValueList = new List<CashValueDetail>();
        
        giClaimList = new List<GIClaim>();
        giEndorsementList = new List<GIEndorsement>();
        premiumBreakdownList = new List<PremiumBreakdown>();
        policyChangeLifeList = new List<PolicyChangeLife>();
        policyChangeList = new List<PolicyChange>();
        endorsementGIList = new List<EndorsementGI>();
        riskInfoList = new List<RiskInfo>();
        
        ownRiskData = new OwnRisk();
        
        TOCList = new List<TableofContent>();
        accountDetailList = new List<AccountDetail>();
        premiumDetailList = new List<PremiumDetail>();
        interestInfoList = new List<InterestInfo>();
        
        claimDetailLifeList = new List<ClaimDetailLife>();
        claimDetailGIList = new List<ClaimDetailGI>();
        claimDetailGIList2 = new List<ClaimDetailGI>();
        
        assessmentNotesDetailList = new List<AssessmentNotesDetail>();
        
        //assessmentNotesSummaryUWList = new List<AssessmentNotesSummary>();
        assessmentNotesDetailUWList = new List<AssessmentNotesDetail>();
        
        assessmentNotesSummaryPOSList = new List<AssessmentNotesSummary>();
        assessmentNotesDetailPOSList = new List<AssessmentNotesDetail>();
        
        assessmentNotesSummaryPAList = new List<AssessmentNotesSummary>();
        assessmentNotesDetailPAList = new List<AssessmentNotesDetail>();
        
        assessmentNotesSummaryCLMList = new List<AssessmentNotesSummary>(); 
        assessmentNotesDetailCLMList  = new List<AssessmentNotesDetail>();
        
        assessmentNotesSummaryOTHList = new List<AssessmentNotesSummary>();
        assessmentNotesDetailOTHList = new List<AssessmentNotesDetail>();
            
        cashValueDetailList =  new List<CashValueDetail>();

        RHSList = new List<Case>();     
        CHSList = new List<Case>();
        InquiryList = new List<Case>();
        
        contactId = controller.getID();
        sessionID = contactID + '-'+ CCCUtils.getSessionID(); 
        
        if (contactId == null || contactId == '') {
            contactId = Apexpages.currentPage().getParameters().get('contactID');
            sessionID = Apexpages.currentPage().getParameters().get('sessionID');
        }   

        system.debug ('>>>>> sessionID : ' + sessionID);
        
        String operation = Apexpages.currentPage().getParameters().get('operation');
        String classType = Apexpages.currentPage().getParameters().get('classType');
        String refNo = Apexpages.currentPage().getParameters().get('refNo');
        string classTypeTitle;
        
        system.debug(operation+'-'+classType+'-'+refNo);
        
        if ((operation != null || operation != '') && (classType != null || classType != '') && (refNo != null || refNo != '') ) {
            if (classType=='POS') { classTypeTitle='POS'; }
            else if (classType=='PA') { classTypeTitle='Policy Admin'; }
            else if (classType=='UW') { classTypeTitle='Under Writing'; }
            else if (classType=='OTH') { classTypeTitle='Other'; }
            else if (classType=='CRM') { classTypeTitle='Claim'; }
            
            assessmentNotesDetailTitle='Assessment Notes (Life) ' + classTypeTitle +' - Detailed List (RefNo.' + refNo + ')' ;
        }
        
        agentServicingCode = Apexpages.currentPage().getParameters().get('agentServicingCode');
        agentProducingCode = Apexpages.currentPage().getParameters().get('agentProducingCode');
        system.debug ('==== agentServicingCode : ' + agentServicingCode);
        system.debug ('==== agentProducingCode : ' + agentProducingCode);
        system.debug('contactId on constructor : ' +contactId);
        
        if (system.label.WS_JSON_Display =='true' ) { isDisplayJSON = true; }
        else isDisplayJSON = false;
    }
    
    public Double offset{
        get {
            TimeZone tz = UserInfo.getTimeZone();
            //Milliseconds to Day
            return tz.getOffset(DateTime.now()) / (1000 * 3600 * 24.0);
        }
    }
    
    //--Added by Suryono 8/8/2019
    public void getClaimListFromConnector() {
        /*
        //--Dummy record
        claimDetailGIList = new List<ClaimDetailGI>();
        ClaimDetailGI claimDtl = new ClaimDetailGI();
        claimDtl.ClaimRegistrationNo = 'regNoNull';
        claimDtl.ClaimStatus = 'statusNull';
        claimDtl.BranchCode = 'branchCdNull';
        claimDtl.ClientName = 'clientNameNull';
        claimDtl.NotificationDate = Date.today();
        claimDtl.RegistrationDate = Date.today();
        claimDtl.DateofLoss = Date.today();
        claimDtl.Description = 'DescriptionNull';
        claimDtl.AccidentPlace = 'accPlaceNull';
        claimDtl.RepairShop = 'repShopNull';
        claimDtl.ApprovalPaymentDate = Date.today();
        claimDtl.PaymentDate = Date.today();
        claimDtl.DriverName = 'drvNameNull';
        claimDtl.BenefitOfType = 'bftTypeNull';
        claimDtl.DischargeDate = Date.today();
        claimDetailGIList.add(claimDtl);
        System.debug('Dummy Claim Loaded');
        */
        
        //Update, 11 Maret 2020
        /*try {
            System.debug('entity : ' + entity + ', policyApp : ' + policyApp + ', policyNo : ' + policyNo);
            EIPJson eipClaim = new EIPJson();
            eipClaim = EIPConnector.getClaimDetails('Claim', entity, policyApp, policyNo);
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){
            System.debug('Debug message : ' + e);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }*/
    }
    
    /*
    public String getEIPPremiumBreakdownList() {
        try {
            EIPJson eipPremiumBreakdown = new EIPJson();
            if(Test.isRunningTest() == false) {
                eipPremiumBreakdown = EIPConnector.getPremiumBreakdown('Premium Breakdown', entity, policyApp, policyNo, true);
                System.debug('eipPremiumBreakdown : ' + eipPremiumBreakdown);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            premiumBreakdownList = new List<PremiumBreakdown>();*/
            
            /*string PolicyNo = (string) (string) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyNO');
            Date EffectiveDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyEffectiveDTTM'), 'yyyymmdd' );
            Date ExpiredDate = (date) CCCUtils.strToDate ( (String) CCCUtils.getStringDataOnMap(mapData, 'Body::AgSa_InsurancePolicy_Type::policyExpirationDTTM'), 'yyyymmdd' );    
            */
            
            //Policy No
            /*String PolicyNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyNO;
            
            //Effective Date
            String ed = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyEffectiveDTTM;
            String year_effDate;
            String month_effDate;
            String day_effDate;
            for(integer i = 0; i < ed.length(); i++) {
                if(i<4) {
                    year_effDate = ed.substring(0,4);
                } 
                if(i>=4 && i<=5) {
                    month_effDate = ed.substring(4,6);
                } 
                if(i>=6 && i<=7) {
                    day_effDate = ed.substring(6,8);
                }   
            }
            String effDate = day_effDate + '/' + month_effDate + '/' + year_effDate;
            System.debug('effDate: '+effDate);
            
            //Expired Date
            String exD = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyExpirationDTTM;
            String year_expDate;
            String month_expDate;
            String day_expDate;
            for(integer i = 0; i < exD.length(); i++) {
                if(i<4) {
                    year_expDate = exD.substring(0,4);
                } 
                if(i>=4 && i<=5) {
                    month_expDate = exD.substring(4,6);
                } 
                if(i>=6 && i<=7) {
                    day_expDate = exD.substring(6,8);
                }   
            }
            String expDate = day_expDate + '/' + month_expDate + '/' + year_expDate;
            System.debug('expDate: '+expDate);
            
            
            //EffectiveDate & ExpiredDate -- Date (parse)
            Date EffectiveDate = Date.parse(effDate);
            Date ExpiredDate = Date.parse(expDate);
            
            
            Integer countPremiumBreakdownList = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct.size();
            for(Integer i=0; i < countPremiumBreakdownList; i++) {
                PremiumBreakdown pb = new PremiumBreakdown();
                pb.InsuranceProductCd = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductCd;
                pb.PlanCode = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCd;
                pb.PlanType = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planTypeCD;
                pb.PlanEffectiveDate = Date.parse(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleEffectiveDt); //-- Date
                pb.PlanExpiredDate = Date.parse(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleExpirationDt); //-- Date
                pb.PlanSI = Decimal.valueOf (eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planSI);
                pb.ModalPlanPremium = Decimal.valueOf (eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].premium);
                pb.PlanStatus = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planStatus;
                pb.ClassCode = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planClassCD;
                pb.ModalPlanLoading = Decimal.valueOf (eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].modalPlanLoading);
                pb.TerminationDate = Date.parse(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].terminationDt);
                
                premiumBreakdownList.add(pb);
            }
            
        } catch(EIPConnector.NoDataException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'no data for this response.'));
            system.debug('error NoDataException: '+e);
        } catch(EIPConnector.EIPConnectorException e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
            system.debug('error EIPConnectorException: '+e);
        } catch(Exception e){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
            system.debug('error Exception: '+e);
        }
        return null;
    }*/
    
    
    //Update Comment
    /*public String getEIPCustomerInfoList() {
        try {
            EIPJson eipCustomerInfo = new EIPJson();
            if(Test.isRunningTest() == false) { eipCustomerInfo = EIPConnector.getGIPolicyDetail('Customer Profile', entity, policyApp, policyNo, '');
                System.debug('eipCustomerInfo : ' + eipCustomerInfo);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            policyDetailGIData.No   =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.fullNM;
            policyDetailGIData.Name =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.fullNM;
            policyDetailGIData.FirstName =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.firstNM;
            policyDetailGIData.MiddleName =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.middleNM;
            policyDetailGIData.LastName =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.lastNM;
            policyDetailGIData.Salutation =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.salutationTxt;
            policyDetailGIData.Title =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.titleTXT;
            policyDetailGIData.InsuredName =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].hasPersonalDetailsIn[0].fullNM;
            policyDetailGIData.CustomerID =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.individualUniqueID;
            policyDetailGIData.CustomerPolicyNo =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyNO;
            policyDetailGIData.Phone1 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].telephoneNO;
            policyDetailGIData.Phone2 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].telephoneNO2;
            policyDetailGIData.Mobile1 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO;
            policyDetailGIData.Mobile2 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO2;
            policyDetailGIData.Email1 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].emailAddress;
            policyDetailGIData.Email2 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].emailAddress2;
            policyDetailGIData.Fax1 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].faxNO;
            policyDetailGIData.Fax2 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].faxNO2;
            policyDetailGIData.ZipCode =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].postalCD;
            policyDetailGIData.City =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].cityNM;
            //policyDetailGIData.InputerID =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].registeredBy;
            policyDetailGIData.Address1 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine1;
            policyDetailGIData.Address2 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine2;
            policyDetailGIData.Address3 =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine3;
            policyDetailGIData.Contact =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasRelationContact.fullNM;
            policyDetailGIData.ContactAddress =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine1;
            policyDetailGIData.ContactPhone =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].telephoneNO;
            policyDetailGIData.Curr =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].currencyCD;
            policyDetailGIData.MarketingOfficerName =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeNM;
            policyDetailGIData.MarketingOfficerCode =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeCD;
            policyDetailGIData.MarketingOfficerDept =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeDept;
            policyDetailGIData.TransactionTypeDescription =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].transactionTypeDesc;
            policyDetailGIData.IntermediaryTypeDescription =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].intermediaryTypeDesc;
            policyDetailGIData.CustomerTypeDescription =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.customerTypeCD;
            policyDetailGIData.RelatedPolicy =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.relatedPolicyholdersCnt;
            policyDetailGIData.Description =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].generalRk;
            policyDetailGIData.Gender =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.genderCD;
            policyDetailGIData.Married =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.maritalStatusCD;
            policyDetailGIData.Country =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].countyNm;
            policyDetailGIData.IDPassportNumber =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.passportNo;
            policyDetailGIData.Nationality =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.nationalityCD;
            policyDetailGIData.Occupation =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.occupation;
            policyDetailGIData.Language =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.primaryLanguageCd;
            policyDetailGIData.Birthdate =  CCCUtils.strToDate( eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthDT, 'yyyymmdd');
            policyDetailGIData.Age = CCCUtils.birthToAge((Date) policyDetailGIData.Birthdate);     
            policyDetailGIData.Birthplace =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.birthPlace;
            policyDetailGIData.VIP =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.customerClassCD;
            policyDetailGIData.AlternateAddress =  eipCustomerInfo.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].addressLine4;
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }*/
    
    
    /*public String getEIPPolicyDetailList() {
        try {
            EIPJson eipPolicyDetail = new EIPJson();
            if(Test.isRunningTest() == false) { eipPolicyDetail = EIPConnector.getGIPolicyDetail('Policy Details', entity, policyApp, policyNo, '');
                System.debug('eipPolicyDetail : ' + eipPolicyDetail);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            
            //policyDetailList = new List<PolicyDetailGI>();
            
            //policyDetailGIData.PolicyNo = policyNo;
            //policyDetailGIData.PolicyHolder = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.relatedPolicyholdersCnt;
            
            Integer countDetailsOfPolicyTransactionIn = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn.size();
            Integer countDetailsOfRisksIn = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn.size();
            Integer countIsAssociatedWithGIInsuranceProduct = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithGIInsuranceProduct.size();
            Integer countGIPolicyEndorsementIn = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasGIPolicyEndorsementIn.size();
            Integer countAccountDetailsIn = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasAccountDetailsIn.size();
            
            
            policyDetailGIData.PolicyNo = policyNo;
            policyDetailGIData.PolicyHolder = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.relatedPolicyholdersCnt;
            policyDetailGIData.ReferenceNo = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].referenceNO;
            policyDetailGIData.Insured = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID;
            policyDetailGIData.StartDate = (date) CCCUtils.strToDate( eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueDt, 'yyyymmdd');
            policyDetailGIData.EndDate = (date) CCCUtils.strToDate( eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyExpirationDTTM, 'yyyymmdd');
            policyDetailGIData.Premium = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].premiumAMT;
            
            //   Dikomen karena bikin field dibawahnya tidak muncul/error.
            //policyDetailGIData.PolicyDate = CCCUtils.strToDate(eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyEffectiveDTTM, 'yyyymmdd');
            //policyDetailGIData.ReferenceDate = (date) CCCUtils.strToDate( eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].referenceDT, 'yyyymmdd');
            //policyDetailGIData.CoverDate = (date) CCCUtils.strToDate( eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].effectiveDTTM, 'yyyymmdd');
            
            policyDetailGIData.Segment = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policySegment;
            policyDetailGIData.BranchName = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueBranchNM;
            policyDetailGIData.BranchCode = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].issueBranchCD;
            policyDetailGIData.StatusDescription = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyRK;
            policyDetailGIData.TSI = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].isAssociatedWithGIInsuranceProduct[0].hasGIPolicySegmentDetailsIn[0].sumInsured;
            policyDetailGIData.CertificateNo = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].certificateNo;
            policyDetailGIData.Usage = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasAccountDetailsIn[0].usageCd;
            policyDetailGIData.MarketingOfficerName = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeNM;
            policyDetailGIData.MarketingOfficerCode = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeCD;  
            policyDetailGIData.MarketingOfficerDept = eipPolicyDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasProducerInformationIn[0].gaOfficeDept;
            
            system.debug('PolicyNo: '+policyDetailGIData.PolicyNo);
            system.debug('PolicyHolder: '+policyDetailGIData.PolicyHolder);
            system.debug('ReferenceNo: '+policyDetailGIData.ReferenceNo);
            system.debug('Insured: '+policyDetailGIData.Insured);
            system.debug('StartDate: '+policyDetailGIData.StartDate);
            system.debug('EndDate: '+policyDetailGIData.EndDate);
            system.debug('Premium: '+policyDetailGIData.Premium);
            system.debug('PolicyDate: '+policyDetailGIData.PolicyDate);
            system.debug('ReferenceDate: '+policyDetailGIData.ReferenceDate);
            system.debug('CoverDate: '+policyDetailGIData.CoverDate);
            system.debug('Segment: '+policyDetailGIData.Segment);
            system.debug('BranchName: '+policyDetailGIData.BranchName);
            system.debug('BranchCode: '+policyDetailGIData.BranchCode);
            system.debug('StatusDescription: '+policyDetailGIData.StatusDescription);
            system.debug('TSI: '+policyDetailGIData.TSI);
            system.debug('CertificateNo: '+policyDetailGIData.CertificateNo);
            system.debug('Usage: '+policyDetailGIData.Usage);
            system.debug('MarketingOfficerName: '+policyDetailGIData.MarketingOfficerName);
            system.debug('MarketingOfficerCode: '+policyDetailGIData.MarketingOfficerCode);
            system.debug('MarketingOfficerDept: '+policyDetailGIData.MarketingOfficerDept);
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }*/
    //END - Update Comment
    
    
    public String getEIPPolicyChangeList() {
        try {
            EIPJson eipPolicyChange = new EIPJson();
            if(Test.isRunningTest() == false) { eipPolicyChange = EIPConnector.getGIPolicyDetail('Policy Change', entity, policyApp, policyNo, '');
                System.debug('eipPolicyChange : ' + eipPolicyChange);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            endorsementGIList = new List<EndorsementGI>();
            
            Integer countBenefitList = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
            
            for(Integer i=0; i < countBenefitList; i++) {
                EndorsementGI dataRec = new EndorsementGI();
                
                //bnf.PlanCode = eipPolicyChange.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCD;
                //bnf.BenefitCode = eipPolicyChange.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitCD;
                //bnf.BenefitDesc = eipPolicyChange.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitDESC;
                
                dataRec.CertificateNo = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNo;
                dataRec.ContractType = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].contractType;
                dataRec.InforceDate = (date) CCCUtils.strToDate ( eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].inforceDate, 'yyyymmdd');
                
                dataRec.StartDate = (date) CCCUtils.strToDate ( eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].issueDt, 'yyyymmdd');
                dataRec.EndDate = (date) CCCUtils.strToDate ( eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyExpirationDTTM, 'yyyymmdd');
                
                dataRec.EndorsementRemark = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRk;
                dataRec.StatusDescription = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyRK;
                dataRec.TypeDescription  = eipPolicyChange.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].typeDesc;

                endorsementGIList.add(dataRec);
            }
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    //25 Nov 2019
    public String getEIPPremiumBreakdownList() {
        try {
            EIPJson eipPremiumBreakdown = new EIPJson();
            if(Test.isRunningTest() == false) { eipPremiumBreakdown = EIPConnector.getPremiumBreakdown('Premium Breakdown', entity, policyApp, policyNo, true);
                System.debug('eipPremiumBreakdown : ' + eipPremiumBreakdown);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            premiumBreakdownList = new List<PremiumBreakdown>();
            
            Date EffectiveDate = null;
            Date ExpiredDate = null;
            
            System.debug('TEST PREMIUM BREAKDOWN');
            if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyEffectiveDTTM != null){ EffectiveDate = (date) CCCUtils.strToDate ( eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyEffectiveDTTM, 'yyyymmdd' );
                System.debug('EffectiveDate: '+EffectiveDate);
            }
            
            if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyExpirationDTTM != null){ ExpiredDate = (date) CCCUtils.strToDate ( eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.policyExpirationDTTM, 'yyyymmdd' );
                System.debug('ExpiredDate: '+ExpiredDate);            
            }
            
            Integer countPremiumBreakdownList = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct.size();
            System.debug('countPremiumBreakdownList: '+countPremiumBreakdownList);
            
            Integer countList = 0;
            if(countPremiumBreakdownList > 1000){ countList = 1000; } 
            else { countList = countPremiumBreakdownList;  }
            System.debug('countList: '+countList);
            
            for(Integer i=0; i < countList; i++) {
                PremiumBreakdown pb = new PremiumBreakdown();
                
                //pb.InsuranceProductCd = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductCd;
                /*pb.TransactionNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].policyProductFormCd;
                pb.ProductType = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].productTypeCD;
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn != null){
                    pb.GrossPremium = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minAnnualizedPayment);
                    pb.NettPremium = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minModalPayment);
                }
                pb.RiskNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].guarRateInd;
                pb.InsuredNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductCd;
                pb.InsuredName = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductRk;
                pb.PlanCode = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCd;*/
                
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].policyProductFormCd != null){ pb.TransactionNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].policyProductFormCd; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].productTypeCD != null){ pb.ProductType = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].productTypeCD; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn != null){ pb.GrossPremium = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minAnnualizedPayment); pb.NettPremium = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minModalPayment); }
                
                /*if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minModalPayment != null){
                    pb.NettPremium = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasDetailsRecordIn.minModalPayment);
                }*/
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].guarRateInd != null){ pb.RiskNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].guarRateInd; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductCd != null){ pb.InsuredNo = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductCd; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductRk != null){ pb.InsuredName = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].insuranceProductRk; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCd != null){ pb.PlanCode = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCd; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planTypeCD != null){ pb.PlanType = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planTypeCD; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleEffectiveDt != null && eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleEffectiveDt != '99999999' && eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleEffectiveDt != '0'){ pb.PlanEffectiveDate = (date) CCCUtils.strToDate (eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleEffectiveDt, 'yyyymmdd' ); } 
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleExpirationDt != null && eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleExpirationDt != '99999999' && eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleExpirationDt != '0'){ pb.PlanExpiredDate = (date) CCCUtils.strToDate (eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].saleExpirationDt, 'yyyymmdd' ); }
                //pb.PlanEffectiveDate = EffectiveDate;
                //pb.PlanExpiredDate = ExpiredDate;
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planSI != null){ pb.PlanSI = CCCUtils.strToDec(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planSI); }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].premium != null){ pb.ModalPlanPremium = CCCUtils.strToDec( eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].premium ); }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planStatus != null){ pb.PlanStatus = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].planStatus; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planClassCD != null){ pb.ClassCode = eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planClassCD; }
                
                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].modalPlanLoading != null){ pb.ModalPlanLoading = CCCUtils.strToDec( eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasPlanDetailsIn[0].modalPlanLoading ); }

                if(eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].terminationDt != null && eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].terminationDt != '99999999'){ pb.TerminationDate = (date) CCCUtils.strToDate ( eipPremiumBreakdown.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].terminationDt, 'yyyymmdd'); }
                
                premiumBreakdownList.add(pb);
            }
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    
    public String getEIPRiskDetailList() {
        try {
            EIPJson eipRiskDetail = new EIPJson();
            if(Test.isRunningTest() == false) { eipRiskDetail = EIPConnector.getGIPolicyDetail('Risk Detail', entity, policyApp, policyNo, '');
                System.debug('eipRiskDetail : ' + eipRiskDetail);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            riskDetailList = new List<RiskDetail>();
            
            Integer countRiskDetailList = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
            System.debug('countRiskDetailList: '+countRiskDetailList);
            for(Integer i=0; i < countRiskDetailList; i++) {
                //RiskDetail rd = new RiskDetail();
                
                Integer countCoverage = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct.size();
                System.debug('countCoverage: '+countCoverage);
                if(countCoverage < 1000){
                    for(Integer j=0; j < countCoverage; j++) {
                        RiskDetail rd = new RiskDetail();
                        rd.Coverage =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].planCD;
                        rd.StartDate =  (date) CCCUtils.strToDate ( eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].saleEffectiveDt, 'yyyymmdd' );
                        
                        if(eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].terminationDt != '99999999'){ rd.EndDate = (date) CCCUtils.strToDate ( eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].terminationDt, 'yyyymmdd'); }
                        
                        rd.TransactionNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].policyProductFormCd;
                        
                        
                        Integer countMemberNo = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn.size();
                        System.debug('countMemberNo: '+countMemberNo);
                        for(Integer k=0; k < countMemberNo; k++) { rd.MemberNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn[k].benefitCD; rd.MemberName =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn[k].benefitDESC; }
                        
                        Integer countPlanSI = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasPlanDetailsIn.size();
                        System.debug('countPlanSI: '+countPlanSI);
                        for(Integer l=0; l < countPlanSI; l++) { rd.PlanNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasPlanDetailsIn[l].planSI; }
                        
                        rd.RiskNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].guarRateInd;
                        
                        riskDetailList.add(rd);
                    }
                } else {
                    for(Integer j=0; j < 999; j++) {
                        RiskDetail rd = new RiskDetail();
                        rd.Coverage =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].planCD;
                        rd.StartDate =  (date) CCCUtils.strToDate ( eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].saleEffectiveDt, 'yyyymmdd' );
                        
                        if(eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].terminationDt != '99999999'){ rd.EndDate = (date) CCCUtils.strToDate ( eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].terminationDt, 'yyyymmdd'); }
                        rd.TransactionNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].policyProductFormCd;
                        
                        
                        Integer countMemberNo = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn.size();
                        System.debug('countMemberNo: '+countMemberNo);
                        for(Integer k=0; k < countMemberNo; k++) { rd.MemberNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn[k].benefitCD; rd.MemberName =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasBenefitDetailsIn[k].benefitDESC;
                        }
                        
                        Integer countPlanSI = eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasPlanDetailsIn.size();
                        System.debug('countPlanSI: '+countPlanSI);
                        for(Integer l=0; l < countPlanSI; l++) { rd.PlanNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].hasPlanDetailsIn[l].planSI; }
                        
                        rd.RiskNo =  eipRiskDetail.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[j].guarRateInd;
                        
                        riskDetailList.add(rd);
                    }
                }
            }
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    //END - 25 Nov 2019
    
    
    public String getEIPBenefitDetailList() {
        try {
            EIPJson eipBenefit = new EIPJson();
            if(Test.isRunningTest() == false) { eipBenefit = EIPConnector.getPremiumBreakdown('Benefit Detail', entity, policyApp, policyNo, true);
                System.debug('eipBenefit : ' + eipBenefit);
            } else if(Test.isRunningTest() == true) {
                  
            }
            
            benefitDetailList = new List<BenefitDetail>();
            
            Integer countBenefitList = eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct.size();
            system.debug('countBenefitList: '+countBenefitList);
            for(Integer i=0; i < countBenefitList; i++) {
                BenefitDetail bnf = new BenefitDetail();
                bnf.PlanCode = eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].planCD;
                bnf.BenefitCode = eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitCD;
                bnf.BenefitDesc = eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitDESC;
                if(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitRK == 'day') { bnf.BenefitInDay = CCCUtils.strToDec(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitAMT); }
                else if(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitRK == 'visit') { bnf.BenefitInVisit = CCCUtils.strToDec(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitAMT); }
                else if(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitRK == 'month') { bnf.BenefitInMonth = CCCUtils.strToDec(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitAMT); }
                else if(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitRK == 'year')  { bnf.BenefitInYear = CCCUtils.strToDec(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitAMT); }
                else if(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitRK == 'life')  { bnf.BenefitInLife = CCCUtils.strToDec(eipBenefit.Body.AgSa_InsurancePolicy_Type.isAssociatedWithLifeInsuranceProduct[i].hasBenefitDetailsIn[0].benefitAMT); }

                benefitDetailList.add(bnf);
            }
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    /*===== untuk get product code sebelum tombol search di klik =====*/
    /*public String codeClaimSearchHeader {
        get{
            EIPJson eipClaim = new EIPJson();
            if(Test.isRunningTest() == false) { 
                eipClaim = EIPConnector.getGIClaimDetail('Claim', entity, policyApp, policyNo);
                System.debug('eipClaim : ' + eipClaim);
            } else if(Test.isRunningTest() == true) {
                
            }
            Integer countClaimList = 0;
            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn != Null){
                countClaimList = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn.size();
            }
            if(countClaimList > 0){
                for(Integer i=0; i < countClaimList; i++) {
                    ClaimDetailGI clm = new ClaimDetailGI();
                    
                    clm.Product = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].insuranceProductRk;
                    ProductCode = clm.Product;
                    return ProductCode;
                }
            }
            return null;
        }
        set;
    }*/
    
    public String getEIPClaimDetailList() {
        try {
            EIPJson eipClaim = new EIPJson();
            Map<String,String> start = new Map<String,String>();
            Map<String,String> endD = new Map<String,String>();
            String dateError = 'No Error';
            
            if(StartDate == Null && EndDate == Null){
                dateError = 'Please Input Start Date/End Date';
            }            
            
            if(StartDate != Null || EndDate != Null){
                if(StartDate != Null && EndDate == Null){
                    EndDate = StartDate.addDays(30);
                    if(EndDate > System.today()){
                        EndDate = System.today();
                    }
                } 
                
                if(StartDate == Null && EndDate != Null){ StartDate = EndDate.addDays(-30);
                }
                
                if(StartDate.daysBetween(EndDate) > 30){ dateError = 'The range cannot be more than 30 days';
                } 
                
                if(StartDate > EndDate){ dateError = 'Start Date must be smaller than End Date';
                }
                
                if(StartDate > System.today() || EndDate > System.today()){ dateError = 'Start Date/End Date cannot greater than today';
                }
                
            }
            
            if(dateError != 'No Error'){
                claimDetailGIList = new List<ClaimDetailGI>();
                if(dateError == 'Please Input Start Date/End Date'){
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, dateError));
                }
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.WARNING, dateError));
            }
            
            if(dateError == 'No Error'){
                String startConvert = String.valueOf(StartDate.year()) +(String.valueOf(StartDate.month()).length() != 1 ? String.valueOf(StartDate.month()) : '0'+String.valueOf(StartDate.month())) 
                    +(String.valueOf(StartDate.day()).length() != 1 ? String.valueOf(StartDate.day()) : '0'+String.valueOf(StartDate.day()));
                start.put(EIPConstant.VALID_FROM_DTTM, startConvert);
                
                String endConvert = String.valueOf(EndDate.year()) +(String.valueOf(EndDate.month()).length() != 1 ? String.valueOf(EndDate.month()) : '0'+String.valueOf(EndDate.month())) 
                    +(String.valueOf(EndDate.day()).length() != 1 ? String.valueOf(EndDate.day()) : '0'+String.valueOf(EndDate.day()));
                start.put(EIPConstant.VALID_TO_DTTM, endConvert);
                
                /*String endConvert = String.valueOf(EndDate.year()) +(String.valueOf(EndDate.month()).length() != 1 ? String.valueOf(EndDate.month()) : '0'+String.valueOf(EndDate.month())) 
                    +(String.valueOf(EndDate.day()).length() != 1 ? String.valueOf(EndDate.day()) : '0'+String.valueOf(EndDate.day()));
                endD.put(EIPConstant.VALID_TO_DTTM, endConvert);*/
                
                if(Test.isRunningTest() == false) { 
                    eipClaim = EIPConnector.getGIClaimDetail('Claim', entity, policyApp, policyNo, start/*, endD*/);
                    System.debug('eipClaim : ' + eipClaim);
                } else if(Test.isRunningTest() == true) {
                    
                }
                
                claimDetailGIList = new List<ClaimDetailGI>();
                Integer countClaimList = 0;
                if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn != Null){
                    countClaimList = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn.size();
                }
                system.debug('countClaimList: '+countClaimList);
                
                if(countClaimList > 0){
                    for(Integer i=0; i < countClaimList; i++) {
                        ClaimDetailGI clm = new ClaimDetailGI();
                        
                        clm.Product = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].insuranceProductRk;
                        ProductCode = clm.Product;
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimNumber != Null){
                            clm.ClaimRegistrationNo = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimNumber;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimStatusCode != Null){
                            clm.ClaimStatus = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimStatusCode;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].branchCode != Null){
                            clm.BranchCode = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].branchCode;
                        }
                        
                        // Fixing by Faizir if canBeIndividual != null by Faizir 2020-03-12
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual != null){
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.fullNM != null){ clm.ClientName = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.fullNM;
                            }
                            
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.otherNm != Null){ clm.DriverName = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.otherNm;
                            }
                            
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.occupation != Null){ clm.Occupation = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.occupationClassCd;
                            }
                            
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.firstNM != Null){ clm.PayeeName = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.firstNM;
                            }
                            
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.processedDttm != Null){ clm.AuthDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.processedDttm, 'yyyymmdd');
                            }
                            
                            if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.localNM != Null){ clm.Payee = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].canBeIndividual.localNm;
                            }
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].notificationDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].notificationDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].notificationDate != '0'){ clm.NotificationDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].notificationDate, 'yyyymmdd');  
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimOpenDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimOpenDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimOpenDate != '0'){ clm.RegistrationDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimOpenDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossDate != '0'){ clm.DateofLoss = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].description != Null){ clm.Description = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].description;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimantNumber != Null){ clm.ClaimHandler = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimantNumber;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossCause != Null){ clm.Situation = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].lossCause;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].approvalPaymentDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].approvalPaymentDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].approvalPaymentDate != '0'){ clm.ApprovalPaymentDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].approvalPaymentDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimPaymentDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimPaymentDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimPaymentDate != '0'){ clm.PaymentDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimPaymentDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimSubmissionDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimSubmissionDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimSubmissionDate != '0'){ clm.DateOfReclaim = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].claimSubmissionDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfGIRisksIn[0].coverageRk != Null){ clm.BenefitOfType = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfGIRisksIn[0].coverageRk;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].dischargeDate != Null && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].dischargeDate != '99999999' && eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].dischargeDate != '0'){ clm.DischargeDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].dischargeDate, 'yyyymmdd');
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID != Null){ clm.InsuredName = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfRisksIn[0].insuredID;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].intermediaryTypeDesc != Null){ clm.Intermediary = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].intermediaryTypeDesc;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].customerID != Null){ clm.Accessor = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].customerID;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].endorsementRk != Null){ clm.Conveyance = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].endorsementRk;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].totalClaimAmount != Null){ clm.PaymentAmount = CCCUtils.strToDec(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].totalClaimAmount);
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].brand != Null){ clm.VesselName = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].brand;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].typeDesc != Null){ clm.VesselType = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasGIPolicyEndorsementIn[0].typeDesc;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].customerRK != Null){ clm.InsuredPerson = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].customerRK;
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].totalPaidAmount != Null){ clm.Paid = CCCUtils.strToDec(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasPnCClaimIn[0].totalPaidAmount);
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].transactionNo != Null){ clm.PaymentNumber = eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].transactionNo; 
                        }
                        
                        if(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].transDT != Null){ clm.TransactionDate = (date) CCCUtils.strToDate(eipClaim.Body.AgSa_InsurancePolicy_Type.hasCustomerInformationIn[i].hasPolicyAccount[0].hasDetailsOfPolicyTransactionIn[0].transDT, 'yyyymmdd');
                        }
                        
                        
                        
                        claimDetailGIList.add(clm);
                    }
                } else {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO, 'No data found'));
                }
                
            }
            
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
    
    
    public String getInsuredDetailList() {
        try {
            EIPJson eipInsured = new EIPJson();
            eipInsured = EIPConnector.getGIPolicyDetail('Insured Details', entity, policyApp, policyNo, certificateNo);
            system.debug('eipInsured: '+eipInsured);
            
            insuredDetailList = new List<InsuredDetail>();
            
            Integer countInsuredList = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount.size();
            system.debug('countInsuredList: '+countInsuredList);
            for(Integer i=0; i < countInsuredList; i++) {
                InsuredDetail ins = new InsuredDetail();
                
                ins.Product = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].insuranceProductRk;
                ProductCode = ins.Product;
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNO != Null){ ins.IDNo = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].certificateNO;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM != Null){ ins.Name = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.fullNM;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthPlace != Null){ ins.PlaceofBirth = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthPlace;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthDT != Null && eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthDT != '99999999' && eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthDT != '0'){ ins.DateofBirth = (date) CCCUtils.strToDate(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.birthDT, 'yyyymmdd');
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.genderCD != Null){ ins.Gender = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.genderCD;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].emailAddress != Null){ ins.Email = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].emailAddress;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].mobilePhoneNO != Null){ ins.Mobile = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.hasAddressesIn[0].mobilePhoneNO; 
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].model != Null){ ins.VehicleMerkModel = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].model;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].regNumber != Null){ ins.PoliceRegNo = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].regNumber;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT != Null){ ins.YearofManufacturing = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].manufacturedDT;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[0].planNM != Null){ ins.PolicyCover = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[0].planNM;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].collateralAMT != Null){ ins.SumInsured = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].collateralAMT);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].premiumAMT != Null){ ins.PremiumAmount = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].premiumAMT);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].bonusReserveAmt != Null){ ins.ExtraCoverageLimits = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].bonusReserveAmt);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyRK != Null){ ins.Deductible = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyRK;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRK != Null){ ins.RiskOccupation = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].endorsementRK;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].applicationRk != Null){ ins.ContractWorks = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].applicationRk;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation != Null){ ins.Destination = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].unitLocation;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].remark != Null){ ins.ObjectInsured = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].remark;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].assignmentFlg != Null){ ins.VesselFlag = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].assignmentFlg;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].pooledInd != Null){ ins.NoEmployee = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].pooledInd;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].liabilityAmt != Null){ ins.TPLLimit = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].liabilityAmt);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].eeContribAmt != Null){ ins.LimitOccurrence = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].eeContribAmt);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].erContribAmt != Null){ ins.LimitPeriod = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsRecordIn[0].erContribAmt);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].targetPremiumAmt != Null){ ins.TerritorialLimit = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].targetPremiumAmt;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.ownerIND != Null){ ins.OwnerBusiness = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasCustomerInformationIn[0].canBeIndividual.ownerIND;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsOfRisksIn[0].insuredID != Null){ ins.InsuredName = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsOfRisksIn[0].insuredID;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsOfRisksIn[0].issueAge != Null){ ins.Age = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasDetailsOfRisksIn[0].issueAge;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].forLifeUnitofExposure[0].hasBeneficiaryInformationIn[0].beneficiaryRK != Null){ ins.Beneficiary = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].forLifeUnitofExposure[0].hasBeneficiaryInformationIn[0].beneficiaryRK;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].forLifeUnitofExposure[0].hasBeneficiaryInformationIn[0].relationshipIND != Null){ ins.Relation = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].forLifeUnitofExposure[0].hasBeneficiaryInformationIn[0].relationshipIND;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[0].planCd != Null){ ins.PolicyPlan = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].isAssociatedWithLifeInsuranceProduct[0].planCd;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyReserveAmt != Null){ ins.Premium = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].policyReserveAmt);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].brand != Null){ ins.VesselName = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].brand;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].typeDesc != Null){ ins.VesselType = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].typeDesc;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].model != Null){ ins.ConveyanceName = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].model;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasBilling != Null){
                    if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasBilling.remark1 != Null){
                        ins.DepartureFrom = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasBilling.remark1;
                    }
                    if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasBilling.remark2 != Null){
                        ins.To = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasBilling.remark2;
                    }
                    
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm != Null && eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm != '99999999' && eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm != '0'){ ins.TimeDeparture = (date) CCCUtils.strToDate(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].processedDttm, 'yyyymmdd');
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].generalRk != Null){ ins.TypeCover = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].generalRk;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasPnCClaimIn[0].totalClaimAmount != Null){ ins.LimitAccident = CCCUtils.strToDec(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasPnCClaimIn[0].totalClaimAmount);
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].grossAnnualPremiumAmt != Null){ ins.EstimateCarrying = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].grossAnnualPremiumAmt;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].dividentAccumRt != Null){ ins.RatePremises = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].dividentAccumRt;
                }
				
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].reEntryRt != Null){ ins.RateTransit = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].reEntryRt;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].contractType != Null){ ins.ContractTitle = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].hasGIPolicyEndorsementIn[0].contractType;
                }
                
                if(eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].premiumIndexRt != Null){ ins.RatePremium = eipInsured.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[i].premiumIndexRt;
                }
				
                insuredDetailList.add(ins);
            }
        } catch(EIPConnector.NoDataException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, 'no data for this response.'));
        } catch(EIPConnector.EIPConnectorException e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        } catch(Exception e){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah, silahkan hubungi Admin.'));
        }
        return null;
    }
        
}