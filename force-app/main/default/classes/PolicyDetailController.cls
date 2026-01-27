public class PolicyDetailController {

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
    public List<TrxClaim> trxClaimList {get;set;}
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
    public CCCWebserviceConnectors10.ArrayOfPolicyDetailsRLS ambilRLS {get;set;}
    public CCCWebserviceConnectors10.ArrayOfPolicyDetailsNonRLS ambilNonRLS {get;set;}
    public CCCWebserviceConnectors10.ArrayOfPolicyDetailsGI ambilGI {get;set;}
    
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
        
    public PolicyDetailController(ApexPages.StandardController controller) {

        //string contactId = controller.getID();  //remarked by WK, 20150422
        ambilRLS = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsRLS();
        ambilNonRLS = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsNonRLS();
        ambilGI = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsGI();
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
        contactId = controller.getID();
        //contactId = '0039000001XAPJe'; //Test static ID
    } 
    
    
    //public PolicyDetailController(string id){
    public PolicyDetailController(){
        ambilRLS = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsRLS();
        ambilNonRLS = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsNonRLS();
        ambilGI = new CCCWebserviceConnectors10.ArrayOfPolicyDetailsGI();
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
    
        //List<Contact> contactList = [SELECT Id, Policy_No__c, Entity__c, PolicyApp__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
        List<Contact> contactList = [SELECT Id, Policy_No__c, Entity__c, PolicyApp__c, Phone, MobilePhone, HomePhone, Policy_Status__c, Policy_Effective_Date__c, Agent_Name__c, Agent_Code__c, Agent_Status__c, Premium__c, Segment_Name__c, Branch_Name__c, Branch_Code__c, Date_of_Accident__c, Driver__c, Accident_Place__c, Detail_of_Damage__c, Production_Year__c, Licence_Number__c, Machine_No__c, Chassis_no__c, Vehicle_Type__c, Color__c, Machine_Capacity__c FROM Contact WHERE ID =: contactId];      system.debug('contactList: ' +contactList);
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
            policyNo = contactRec.Policy_No__c;
            entity = contactRec.Entity__c;
            policyApp = contactRec.PolicyApp__c;
            
            //CCCWebserviceConnectors.ArrayOfGetPolicyDetailsClipper ambil = srv.GetPolicyDetailsSFDC(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, '');
            applogWs.id__c = contactId;
            //applogWs.method__c = 'call webservice : CCCWebserviceConnectors10.iServiceSoap()';
            //applogWs.start_date__c = system.now();
            applogWS.StartLongTime__c = system.now().getTime();
            CCCWebserviceConnectors10.iServiceSoap srv = new CCCWebserviceConnectors10.iServiceSoap();
            CreateToken ct = new CreateToken();
            token = ct.getToken();
            
            if(contactRec.PolicyApp__c.toUpperCase() == 'BIS'){
                polisRider.MataUang = 'Rp';
                tipe = 'Non RLS 1'; 
            }
            else if(contactRec.PolicyApp__c.toUpperCase() == 'DMTM'){
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
                if(!Test.isRunningTest()){
                    ambilRLS = srv.GetPolicyDetailsLifeRLS(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                }
                //CCCWebserviceConnectors10.ArrayOfPolicyDetailsRLS ambil = srv.GetPolicyDetailsLifeRLS(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                system.debug('Ambil CCCWebserviceConnectors10.ArrayOfPolicyDetailsRLS: ' +ambilRLS);
                
                //applogWs.end_date__c = system.now();
                applogWs.EndLongTime__c = system.now().getTime();
                applogWs.method__c = 'call webservice : CCCWebserviceConnectors10.GetPolicyDetailsLifeRLS()';
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
                                    if(bsi != null && bsi.trim() != ''){
                                        polisRider.BasicSI = decimal.valueOf(double.valueOf(bsi));

                                    }
                                    else{
                                        polisRider.BasicSI = 0;
                                    }
                                    string ltbprm = bacaString(ambilRLS.PolicyDetailsRLS[i].LTBPRM);
                                    if(ltbprm != null && ltbprm.trim() != ''){
                                        polisRider.TotalPremium = decimal.valueOf(double.valueOf(ltbprm));
                                    }
                                    else{
                                        polisRider.TotalPremium = 0;
                                    }
                                    string ltsi = bacaString(ambilRLS.PolicyDetailsRLS[i].LTSI);
                                    if(ltsi != null && ltsi.trim() != ''){
                                        polisRider.TotalSumInsured = decimal.valueOf(double.valueOf(ltsi));
                                    }
                                    else{
                                        polisRider.TotalSumInsured = 0;
                                    }
                                    string ltrmp = bacaString(ambilRLS.PolicyDetailsRLS[i].LTRMP);
                                    if(ltrmp != null && ltrmp.trim() != ''){
                                        polisRider.RegularTopUp = decimal.valueOf(double.valueOf(ltrmp));
                                    }
                                    else{
                                        polisRider.RegularTopUp = 0;
                                    }
                                    string lilsp = bacaString(ambilRLS.PolicyDetailsRLS[i].LILSP);
                                    if(lilsp != null && lilsp.trim() != ''){
                                        polisRider.LumpSumTopUp = decimal.valueOf(double.valueOf(lilsp));
                                    }
                                    else{
                                        polisRider.LumpSumTopUp = 0;
                                    }
                                    string brprem = bacaString(ambilRLS.PolicyDetailsRLS[i].BRPREM);
                                    if(brprem != null && brprem.trim() != ''){
                                        polisRider.BasicRegPrem = decimal.valueOf(brprem);
                                    }
                                    else{
                                        polisRider.BasicRegPrem = 0;
                                    }
                                    polisRider.PaymentMethod = bacaString(ambilRLS.PolicyDetailsRLS[i].PMTHOD);
                                    polisRider.PaymentMode = bacaString(ambilRLS.PolicyDetailsRLS[i].PMODE);
                                    polisRider.Description = bacaString(ambilRLS.PolicyDetailsRLS[i].STATUSDESC);
                                    try{
                                        double usdapp = bacaDouble(ambilRLS.PolicyDetailsRLS[i].USDAPP);
                                        if(usdapp != null && usdapp != 0){
                                            polisRider.DateofApplication = convertStringToDate(String.valueOf(usdapp.round()));
                                        }
                                        else{
                                            polisRider.DateofApplication = null;
                                        }
                                        double pdoi = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PDOI); 
                                        if(pdoi != null && pdoi != 0){
                                            polisRider.IssuedDate  = convertStringToDate(String.valueOf(pdoi.round()));
                                        }
                                        else{
                                            polisRider.IssuedDate = null;
                                        }
                                        double peff = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PEFF);
                                        if(peff != null && peff != 0){
                                            polisRider.EffectiveDate  = convertStringToDate(String.valueOf(peff.round()));
                                        }
                                        else{
                                            polisRider.EffectiveDate = null;
                                        }
                                        double pexp = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PEXP);
                                        if(pexp != null && pexp != 0){
                                            polisRider.ExpiredDate = convertStringToDate(String.valueOf(pexp.round()));
                                        }
                                        else{
                                            polisRider.ExpiredDate = null;
                                        }
                                        double pterm = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PTERM);
                                        if(pterm != null && pterm != 0){
                                            polisRider.TerminationDate = convertStringToDate(String.valueOf(pterm.round()));
                                        }
                                        else{
                                            polisRider.TerminationDate = null;
                                        }
                                        double pdue = bacaDouble(ambilRLS.PolicyDetailsRLS[i].PDUE);
                                        if(pdue != null && pdue != 0){
                                            polisRider.DueDate1 = convertStringToDate(String.valueOf(pdue.round()));
                                        }
                                        else{
                                            polisRider.DueDate1 = null;
                                        }
                                        double lphofd = bacaDouble(ambilRLS.PolicyDetailsRLS[i].LPHOFD);
                                        if(lphofd != null && lphofd != 0){
                                            polisRider.PremiumHolidayStart = convertStringToDate(String.valueOf(lphofd.round()));
                                        }
                                        else{
                                            polisRider.PremiumHolidayStart = null;
                                        }
                                        double lphotd = bacaDouble(ambilRLS.PolicyDetailsRLS[i].LPHOTD);
                                        if(lphotd != null && lphotd != 0){
                                            polisRider.PremiumHolidayEnd = convertStringToDate(String.valueOf(lphotd.round()));
                                        }
                                        else{
                                            polisRider.PremiumHolidayEnd = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in date format (Policy Detail section): '+e.getMessage());
                                    }
                     
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
                                        if(pdob != null && pdob != 0){
                                            tertanggung.DOB = convertStringToDate(String.valueOf(pdob));
                                        }
                                        else{
                                            tertanggung.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in insured DOB: '+e.getMessage());
                                    }
                                    
                                    tertanggung.Gender = psex;
                                    tertanggung.IdentificationNo = pid;
                                    if(tertanggung.IdentificationNo == '0'){
                                        tertanggung.IdentificationNo = '';
                                    }
                                    tertanggung.EmailAddress = piemal;
                                    if(tertanggung.EmailAddress == '0'){
                                        tertanggung.EmailAddress = '';
                                    }
                                    tertanggung.MobilePhoneNumber = plmbno;
                                    if(tertanggung.MobilePhoneNumber == '0'){
                                        tertanggung.MobilePhoneNumber = '';
                                    }
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
                                    if(payment.TransactionType == '0'){
                                        payment.TransactionType = '';
                                    }
                                    try{
                                        if(wpdos != null && wpdos != 0){
                                            payment.SubmissionDate = convertStringToDate(String.valueOf(wpdos));
                                        }
                                        else{
                                            payment.SubmissionDate = null;
                                        }
                                        if(wpdot != null && wpdot != 0){
                                            payment.PaymentDate = convertStringToDate(String.valueOf(wpdot));
                                        }
                                        else{
                                            payment.PaymentDate = null;
                                        }
                                        if(wpdod != null && wpdod != 0){
                                            payment.DueDate = convertStringToDate(String.valueOf(wpdod));
                                        }
                                        else{
                                            payment.DueDate = null;
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
                                    beneficiaryList.add(benefit);
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
                    ambilNonRLS = srv.GetPolicyDetailsLifeNonRLS(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                }
                //CCCWebserviceConnectors10.ArrayOfPolicyDetailsNonRLS ambil = srv.GetPolicyDetailsLifeNonRLS(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                
                //applogWs.end_date__c = system.now();
                applogWs.EndLongTime__c = system.now().getTime();
                applogWs.method__c = 'call webservice : CCCWebserviceConnectors10.GetPolicyDetailsLifeNonRLS()';
                
                try{    
                    if(ambilNonRLS != null){
                        system.debug('start here (Non RLS)...');
                        
                        panjang = ambilNonRLS.PolicyDetailsNonRLS.size();
                        
                        if(panjang > 0){
                            String temp1 = '';
                            String temp2 = '';
                            String temp3 = '';
                            String temp4 = '';
                            String temp5 = '';
                            String temp6 = '';
                            String temp7 = '';
                            String temp8 = '';
                                
                            for(integer i=0;i<panjang;i++){
                                errorDSRTN = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].DESRTN);
                                system.debug('ErrorDSRTN: '+errorDSRTN);
                                
                                if(errorDSRTN != null && errorDSRTN != '' && (!errorDSRTN.contains('Sukses')) && (!errorDSRTN.contains('SUKSES'))){
                                    ApexPages.Message errEmail = new ApexPages.Message(ApexPages.Severity.ERROR,'There is error on web service. Please contact administrator.'); 
                                    ApexPages.addMessage(errEmail);
                                    isDisplayed = false;
                                    displayGIOnly = false;
                                    break;
                                }
                                if(i==0){
                                    pelanggan.CustomerID = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_ID);
                                    if(pelanggan.CustomerID == '0'){
                                        pelanggan.CustomerID = '';
                                    }
                                    pelanggan.Name =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_NAME); 
                                    pelanggan.PlaceofBirth =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_PLACEOFBIRTH);
                                    if(pelanggan.PlaceofBirth == '0'){
                                        pelanggan.PlaceofBirth = '';
                                    }
                                    try{
                                        string policyowner_dob = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_DOB);
                                        if(policyowner_dob != null && policyowner_dob.trim() != '' && policyowner_dob.trim() != '0' && policyowner_dob.trim() != '00000000'){
                                            pelanggan.DOB = convertStringToDate(policyowner_dob);
                                         }
                                        else{
                                            pelanggan.DOB = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error in DOB: '+e.getMessage());
                                    }
                                    pelanggan.Gender = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_GENDER);
                                    pelanggan.Alamat1 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CORRESPONDENT_ADDRESS1);
                                    pelanggan.Alamat2 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CORRESPONDENT_ADDRESS2);
                                    pelanggan.Alamat3 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CORRESPONDENT_ADDRESS3);
                                    pelanggan.Alamat4 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CORRESPONDENT_ADDRESS4);
                                    pelanggan.EmailAddress = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICYOWNER_EMAIL);
                                    pelanggan.AgentServicing = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_SERVICING);
                                    pelanggan.AgentProducer = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_PRODUCER);
                                    
                                    //Policy Detail
                                    polisRider.PolicyNumber = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICY_NO);
                                    polisRider.ProductCode = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PRODUCT_CODE);
                                    polisRider.ProductName = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PRODUCT_NAME);
                                    polisRider.PolicyStatus = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].POLICY_STATUS);
                                    if(tipe == 'Non RLS 3'){
                                        polisRider.MataUang = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].REFERENCE_NO);
                                    }
                                    polisRider.TotalPremium = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].TOTAL_MODAL_PREMIUM);
                                    polisRider.TotalSumInsured = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].TOTAL_SI);
                                    polisRider.TotalPremiumofBasicPlan = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].BASIC_RIDER_MODPREM);
                                    decimal basic_si = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].BASIC_SI);
                                    if(basic_si != null && basic_si != 0){
                                        polisRider.BasicSI = basic_si;
                                    }
                                    else{
                                        polisRider.BasicSI = 0;
                                    }
                                    polisRider.RegularTopUp = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].RTU_PREMIUM);
                                    polisRider.LumpSumTopUp = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].LUMPSUM_PREMIUM);
                                    polisRider.PaymentMethod = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PPAYMENT_TYPE);
                                    polisRider.PaymentMode = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_MODE);
                                    polisRider.Description = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].STATUSDESC);
                                    decimal basic_rider_modprem = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].BASIC_RIDER_MODPREM);
                                    if(basic_rider_modprem != null && basic_rider_modprem != 0){
                                        polisRider.BasicRiderModPrem = basic_rider_modprem;
                                    }
                                    else{
                                        polisRider.BasicRiderModPrem = 0;
                                    }
                                    string premiumholiday_start = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PREMIUMHOLIDAY_START);
                                    if(premiumholiday_start.trim() != '' && premiumholiday_start.trim() != '0' && premiumholiday_start.trim() != '00000000'){
                                        polisRider.PremiumHolidayStart = convertStringToDate(premiumholiday_start);
                                    }
                                    else{
                                        polisRider.PremiumHolidayStart = null;
                                    }
                                    string premiumholiday_end = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PREMIUMHOLIDAY_END);
                                    if(premiumholiday_end.trim() != '' && premiumholiday_end.trim() != '0' && premiumholiday_end.trim() != '00000000'){
                                        polisRider.PremiumHolidayEnd = convertStringToDate(premiumholiday_end);
                                    }
                                    else{
                                        polisRider.PremiumHolidayEnd = null;
                                    }
                                    polisRider.FundPrice = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDTOTAL);
                                    decimal cash_value = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].CASH_VALUE);
                                    if(cash_value != null && cash_value != 0){
                                        polisRider.CashValue = cash_value;
                                    }
                                    else{
                                        polisRider.CashValue = 0;
                                    }
                                    try{
                                        string date_application = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].DATE_APPLICATION);
                                        if(date_application != null && date_application.trim() != '' && date_application.trim() != '0' && date_application.trim() != '00000000'){
                                            polisRider.DateofApplication = convertStringToDate(date_application);
                                        }
                                        else{
                                            polisRider.DateofApplication = null;
                                        }
                                        string issue_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].ISSUE_DATE);
                                        if(issue_date != null && issue_date.trim() != '' && issue_date.trim() != '0' && issue_date.trim() != '00000000'){
                                            polisRider.IssuedDate  = convertStringToDate(issue_date);
                                        }
                                        else{
                                            polisRider.IssuedDate = null;
                                        }
                                        string effective_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].EFFECTIVE_DATE);
                                        if(effective_date != null && effective_date.trim() != '' && effective_date.trim() != '0' && effective_date.trim() != '00000000'){
                                            polisRider.EffectiveDate  = convertStringToDate(effective_date);
                                        }
                                        else{
                                            polisRider.EffectiveDate = null;
                                        }
                                        string expired_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].EXPIRED_DATE);
                                        if(expired_date != null && expired_date.trim() != '' && expired_date.trim() != '0' && expired_date.trim() != '00000000'){
                                            polisRider.ExpiredDate = convertStringToDate(expired_date);
                                        }
                                        else{
                                            polisRider.ExpiredDate = null;
                                        }
                                        string termination_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].TERMINATION_DATE);
                                        if(termination_date != null && termination_date.trim() != '' && termination_date.trim() != '0' && termination_date.trim() != '00000000'){
                                            polisRider.TerminationDate = convertStringToDate(termination_date);
                                        }
                                        else{
                                            polisRider.TerminationDate = null;
                                        }
                                        string due_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].DUE_DATE);
                                        if(due_date != null && due_date.trim() != '' && due_date.trim() != '0' && due_date.trim() != '00000000'){
                                            polisRider.DueDate2 = convertStringToDate(due_date);
                                        }
                                        else{
                                            polisRider.DueDate2 = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in date format: '+e.getMessage());
                                    }
                                    
                                    //Agent Info
                                    agen.AgentNo =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENTNO);
                                    agen.DistributionCode =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_DIST_CODE);
                                    agen.DistributionType =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_DIST_TYPE);
                                    agen.AgentName =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_NAME);
                                    agen.AgentID =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_ID);
                                    try{
                                        string agent_joindate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_JOINDATE);
                                        if(agent_joindate.trim() != '' && agent_joindate.trim() != null && agent_joindate.trim() != '0' && agent_joindate.trim() != '00000000'){
                                                agen.JoinDate = convertStringToDate(agent_joindate);
                                            }
                                        else{
                                            agen.JoinDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured join date (Agent Info section): '+e.getMessage());
                                    }
                                    agen.Status =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_STATUS);
                                    agen.Area =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_AREA);
                                    agen.HomeAddress1 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_ADDRESS1);
                                    agen.HomeAddress2 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_ADDRESS2);
                                    agen.HomeAddress3 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_ADDRESS3);
                                    agen.HomeAddress4 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_ADDRESS4);
                                    agen.OfficeAddress1 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_OFF_ADDRESS1);
                                    agen.OfficeAddress2 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_OFF_ADDRESS2);
                                    agen.OfficeAddress3 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_OFF_ADDRESS3);
                                    agen.OfficeAddress4 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_OFF_ADDRESS4);
                                    agen.EmailAddress =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_EMAIL);
                                    agen.HomePhone1 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_HOMEPHONE1);
                                    if(agen.HomePhone1 == '0'){
                                        agen.HomePhone1 = '';
                                    }
                                    agen.HomePhone2 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_HOMEPHONE2);
                                    if(agen.HomePhone2 == '0'){
                                        agen.HomePhone2 = '';
                                    }
                                    agen.OfficePhone =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_OFFICEPHONE);
                                    if(agen.OfficePhone == '0'){
                                        agen.OfficePhone = '';
                                    }
                                    agen.MobilePhone1 =  bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].AGENT_MOBILE);
                                    if(agen.MobilePhone1 == '0'){
                                        agen.MobilePhone1 = '';
                                    }
                                }   
                                
                                //Insured
                                string insured_name = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_NAME);
                                string insured_placeofbirth = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_PLACEOFBIRTH);
                                string insured_dob = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_DOB);
                                string insured_gender = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_GENDER);
                                string insured_id = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_ID);
                                string insured_email = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_EMAIL);
                                string insured_mobile = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].INSURED_MOBILE);
                                string relation_with_pholder = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].RELATION_WITH_POLICYHOLDER);
                                
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
                                    insuredList.add(tertanggung);
                                    temp1 = val1;
                                }
                                            
                                //Payment history
                                string payment_type = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_TYPE);
                                string payment_sub_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_SUB_DATE);
                                string payment_txn_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_TXN_DATE);
                                string payment_duedate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_DUEDATE);
                                string payment_amount = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PAYMENT_AMOUNT);
                                
                                val2 = payment_type.trim() +'::'+payment_sub_date.trim() +'::'+payment_txn_date.trim()+'::'+payment_duedate.trim()+'::'+payment_amount.trim();
                                system.debug('Val2 = ' +val2);
                                
                                if(temp2 != val2){
                                    TrxPayment payment = new TrxPayment();
                                    payment.TransactionType = payment_type;
                                    
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
                                    trxPaymentList.add(payment);
                                    temp2 = val2;
                                } 
                                
                                //Claim history
                                string claim_number = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CLAIM_NUMBER);
                                string claim_amount = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CLAIM_AMOUNT);
                                string claim_status = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CLAIM_STATUS);
                                string claim_submission_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CLAIM_SUBMISSION_DATE);
                                string claim_approval_date = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CLAIM_APPROVAL_DATE);
                                string statusdesc = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].STATUSDESC);
                                
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
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    trxClaimList.add(claim);    
                                    temp3 = val3;
                                }           
                                
                                //Beneficiary
                                string beneficiary_name = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_NAME);
                                string beneficiary_dob = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_DOB);
                                string beneficiary_placedob = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_PLACEDOB);
                                string beneficiary_gender = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_GENDER);
                                string beneficiary_relation = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_RELATION);
                                decimal beneficiary_percentage = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].BENEFICIARY_PERCENTAGE);
                                
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
                                    beneficiaryList.add(benefit);
                                    temp4 = val4;
                                }
                                
                                //Fund Detail
                                string fundcode1 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDCODE1);
                                string fundunit1 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDUNIT1);
                                string fundprice1 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDPRICE1);
                                string fundamount1 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDAMOUNT1);
                                
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
                                    detail2.FundCode = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDCODE2);
                                    string fundunit2 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDUNIT2);
                                    if(fundunit2 != null && fundunit2.trim() != ''){
                                        detail2.TotalUnitFund = decimal.valueOf(double.valueOf(fundunit2));
                                    }
                                    else{
                                        detail2.TotalUnitFund = 0;
                                    }
                                    string fundprice2 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDPRICE2);
                                    if(fundprice2 != null && fundprice2.trim() != ''){
                                        detail2.FundPrice = decimal.valueOf(double.valueOf(fundprice2));
                                    }
                                    else{
                                        detail2.FundPrice = 0;
                                    }
                                    string fundamount2 = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDAMOUNT2);
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
                                    string fundnav = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDNAV);
                                    if(fundnav.trim() != '' && fundnav.trim() != '0' && fundnav.trim() != '00000000'){
                                        detailFund.NAVDate = convertStringToDate(fundnav);
                                     }
                                    else{
                                        detailFund.NAVDate = null;
                                    }
                                }catch(Exception e){
                                    system.debug('Error in NAV Date (Fund Detail): '+e.getMessage());
                                }
                                string fundtotal = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].FUNDTOTAL);
                                if(fundtotal != null && fundtotal.trim() != ''){
                                    detailFund.TotFundAmount = decimal.valueOf(double.valueOf(fundtotal));
                                }
                                else{
                                     detailFund.TotFundAmount = 0;
                                }
                                
                                //Premium Breakdown
                                string plan_type = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_TYPE);
                                string plan_code = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_CODE);
                                string plan_status = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_STATUS);
                                string plan_effectivedate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_EFFECTIVEDATE);
                                string plan_expireddate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_EXPIREDDATE);
                                string plan_terminationdate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_TERMINATIONDATE);
                                decimal plan_si = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].PLAN_SI);
                                decimal modal_plan_premium = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].MODAL_PLAN_PREMIUM);
                                decimal modal_plan_loading = bacaDecimal(ambilNonRLS.PolicyDetailsNonRLS[i].MODAL_PLAN_LOADING);
                                
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
                                string transcode = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].TRANSCODE);
                                string transdesc = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].TRANDESC);
                                string submitdate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].SUBMITDATE);
                                string createdate = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].CREATEDATE);
                                string status = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].STATUS);
                                string remarkdesc = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].REMARKDESC);
                                
                                val7 = transcode.trim() +'::'+transdesc.trim()+'::'+submitdate.trim()+'::'+
                                       createdate.trim()+'::'+status.trim()+'::'+remarkdesc.trim();
                                
                                system.debug('Val7: ' +val7);
                                
                                if(temp7 != val7){
                                    PolicyChange pc = new PolicyChange();
                                    pc.TransactionCode = transcode;
                                    pc.TransactionDesc = transdesc;
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
                                string nuprc = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NUPRC);
                                string nfccy = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NFCCY);
                                string ncode = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NCODE);
                                string nsprd = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NSPRD);
                                string ntcod = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NTCOD);
                                string namtp = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NAMTP);
                                string namtu = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NAMTU);
                                string nptyp = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NPTYP);
                                string npmod = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NPMOD);
                                string nfprd = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NFPRD);
                                string nuprd = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NUPRD);
                                string ntdat = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NTDAT);
                                string neffd = bacaString(ambilNonRLS.PolicyDetailsNonRLS[i].NEFFD);
                                
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
            }
            else if(tipe == 'GI'){
                isDisplayed = false;
                displayGIOnly = true;
                
                if(!Test.isRunningTest()){
                    ambilGI = srv.GetPolicyDetailsGI(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                }
                //CCCWebserviceConnectors10.ArrayOfPolicyDetailsGI ambil = srv.GetPolicyDetailsGI(contactRec.Policy_No__c, contactRec.PolicyApp__c, contactRec.Entity__c, ct.getToken());
                
                //applogWs.end_date__c = system.now();
                applogWs.EndLongTime__c = system.now().getTime();
                applogWs.method__c = 'call webservice : CCCWebserviceConnectors10.GetPolicyDetailsGI()';
                
                try{
                    if(ambilGI != null){
                        system.debug('start here (GI)...');
                        
                        panjang = ambilGI.PolicyDetailsGI.size();
                        
                        if(panjang > 0){
                            String temp1 = '';
                            String temp2 = '';
                            String temp3 = '';
                            String temp4 = '';
                                
                            for(integer i=0;i<panjang;i++){
                                errorDSRTN = bacaString(ambilGI.PolicyDetailsGI[i].DESRTN);
                                system.debug('errorDSRTN: ' +errorDSRTN);
                                
                                if(errorDSRTN != null && errorDSRTN != '' && (!errorDSRTN.contains('Sukses')) && (!errorDSRTN.contains('SUKSES'))){
                                    ApexPages.Message errEmail = new ApexPages.Message(ApexPages.Severity.ERROR,'There is error on web service. Please contact administrator.'); 
                                    ApexPages.addMessage(errEmail);
                                    isDisplayed = false;
                                    displayGIOnly = false;
                                    break;
                                }    
                                if(i==0){
                                    //Policy Detail
                                    polisRider.PolicyNumber = bacaString(ambilGI.PolicyDetailsGI[i].POLICYNO);
                                    polisRider.ReferenceNumber = bacaString(ambilGI.PolicyDetailsGI[i].REFNO);
                                    polisRider.CoverNo = bacaString(ambilGI.PolicyDetailsGI[i].COVERNO);
                                    //polisRider.MataUang = bacaString(ambilGI.PolicyDetailsGI[i].AID);   //remarked by WK, 2015112 : quickwins 2
                                    
                                    //begin: added by WK, 2015112 : quickwins 2
                                    string aid = bacaString(ambilGI.PolicyDetailsGI[i].AID);
                                    List<string> aids = aid.split('\\|');
                                    system.debug('******* aid length : '+aids.size());
                                    polisRider.MataUang = aids[0];
                                    system.debug('Mata uang : '+polisRider.MataUang);
                                    polisRider.aids = aid;
                                    polisRider.TSIS = bacaString(ambilGI.PolicyDetailsGI[i].TSI);            
                                    polisRider.PremiumGIS = bacaString(ambilGI.PolicyDetailsGI[i].PREMIUM);  
                                    //end: added by WK, 2015112 : quickwins 2 
                                      
                                    /* remarked by WK, 20151112 : quickwins 2
                                    string tsi = bacaString(ambilGI.PolicyDetailsGI[i].TSI);
                                    if(tsi != null && tsi.trim() != ''){
                                        polisRider.TSI = decimal.valueOf(double.valueOf(tsi));
                                    }
                                    else{
                                        polisRider.TSI = 0;
                                    }
                                    string premium = bacaString(ambilGI.PolicyDetailsGI[i].PREMIUM);
                                    if(premium != null && premium.trim() != ''){
                                        polisRider.PremiumGI = decimal.valueOf(double.valueOf(premium));
                                    }
                                    else{
                                        polisRider.PremiumGI = 0;
                                    }
                                    */
                                    polisRider.Description = bacaString(ambilGI.PolicyDetailsGI[i].DESCRIPTION);
                                    polisRider.Segment = bacaString(ambilGI.PolicyDetailsGI[i].SEGMENT);
                                    polisRider.Branch = bacaString(ambilGI.PolicyDetailsGI[i].Name1);
                                    polisRider.BranchCode = bacaString(ambilGI.PolicyDetailsGI[i].Branch);
                                    polisRider.Insured = bacaString(ambilGI.PolicyDetailsGI[i].INSURED);
                                    polisRider.PolicyStatus = bacaString(ambilGI.PolicyDetailsGI[i].ASTATUS);
                                    polisRider.StatusDesc = bacaString(ambilGI.PolicyDetailsGI[i].STATUSDESC);
                                    try{
                                        string policydate = bacaString(ambilGI.PolicyDetailsGI[i].POLICYDATE);
                                        if(policydate.trim() != '0' && policydate.trim() != '' && policydate.trim() != '00000000'){
                                            polisRider.PolicyDate  = convertStringToDate(policydate);
                                        }
                                        else{
                                            polisRider.PolicyDate = null;
                                        }
                                        string sdate = bacaString(ambilGI.PolicyDetailsGI[i].SDATE);
                                        if(sdate.trim() != '0' && sdate.trim() != '' && sdate.trim() != '00000000'){
                                            polisRider.StartDate = convertStringToDate(sdate);
                                        }
                                        else{
                                            polisRider.StartDate = null;
                                        }
                                        string edate = bacaString(ambilGI.PolicyDetailsGI[i].EDATE);
                                        if(edate.trim() != '0' && edate.trim() != '' && edate.trim() != '00000000'){
                                            polisRider.EndDate = convertStringToDate(edate);
                                        }
                                        else{
                                            polisRider.EndDate = null;
                                        }
                                        string refdate = bacaString(ambilGI.PolicyDetailsGI[i].REFDATE);
                                        if(refdate.trim() != '0' && refdate.trim() != '' && refdate.trim() != '00000000'){
                                            polisRider.ReferenceDate = convertStringToDate(refdate);
                                        }
                                        else{
                                            polisRider.ReferenceDate = null;
                                        }
                                        string coverdate = bacaString(ambilGI.PolicyDetailsGI[i].COVERDATE);
                                        if(coverdate.trim() != '0' && coverdate.trim() != '' && coverdate.trim() != '00000000'){
                                            polisRider.CoverDate = convertStringToDate(coverdate);
                                        }
                                        else{
                                            polisRider.CoverDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in date format: '+e.getMessage());
                                    }
                                    
                                    //Account Info
                                    agen.AgentNo =  string.valueOf(bacaDecimal(ambilGI.PolicyDetailsGI[i].ANO));
                                    agen.AgentName =  bacaString(ambilGI.PolicyDetailsGI[i].AName);
                                    //agen.AgentID =  bacaString(ambilGI.PolicyDetailsGI[i].AID);  remarked by WK, 20151116 - change to below line : quickwin2
                                    agen.AgentID =  polisRider.MataUang;
                                    agen.OfficeAddress1 =  bacaString(ambilGI.PolicyDetailsGI[i].Address_1);
                                    agen.OfficeAddress2 =  bacaString(ambilGI.PolicyDetailsGI[i].Address_2);
                                    agen.OfficeAddress3 =  bacaString(ambilGI.PolicyDetailsGI[i].Address_3);
                                    agen.City =  bacaString(ambilGI.PolicyDetailsGI[i].City);
                                    agen.ZipCode =  bacaString(ambilGI.PolicyDetailsGI[i].ZipCode);
                                    agen.HomePhone1 =  bacaString(ambilGI.PolicyDetailsGI[i].Phone_1);
                                    if(agen.HomePhone1 == '0'){
                                        agen.HomePhone1 = '';
                                    }
                                    agen.HomePhone2 =  bacaString(ambilGI.PolicyDetailsGI[i].Phone_2);
                                    if(agen.HomePhone2 == '0'){
                                        agen.HomePhone2 = '';
                                    }
                                    agen.MobilePhone1 =  bacaString(ambilGI.PolicyDetailsGI[i].Mobile_1);
                                    if(agen.MobilePhone1 == '0'){
                                        agen.MobilePhone1 = '';
                                    }
                                    agen.MobilePhone2 =  bacaString(ambilGI.PolicyDetailsGI[i].Mobile_2);
                                    if(agen.MobilePhone2 == '0'){
                                        agen.MobilePhone2 = '';
                                    }
                                    agen.Fax1 =  bacaString(ambilGI.PolicyDetailsGI[i].Fax_1);
                                    agen.Fax2 =  bacaString(ambilGI.PolicyDetailsGI[i].Fax_2);
                                    agen.TOC =  bacaString(ambilGI.PolicyDetailsGI[i].TOC);
                                    agen.ContactPerson = bacaString(ambilGI.PolicyDetailsGI[i].Contact);
                                    agen.ContactAddress = bacaString(ambilGI.PolicyDetailsGI[i].ContactAddress);
                                    agen.ContactPhone = bacaString(ambilGI.PolicyDetailsGI[i].ContactPhone);
                                    if(agen.ContactPhone == '0'){
                                        agen.ContactPhone = '';
                                    }
                                    agen.A_Type = bacaString(ambilGI.PolicyDetailsGI[i].ATYPE);
                                    agen.C_Type = bacaString(ambilGI.PolicyDetailsGI[i].C_TYPE);
                                    agen.P_Type = bacaString(ambilGI.PolicyDetailsGI[i].PTYPE);
                                    agen.MO_Name = bacaString(ambilGI.PolicyDetailsGI[i].Name);
                                    agen.MO_Code = bacaString(ambilGI.PolicyDetailsGI[i].MO);
                                    agen.UserID = bacaString(ambilGI.PolicyDetailsGI[i].USERID);
                                    agen.CPOLICYNO = bacaString(ambilGI.PolicyDetailsGI[i].CPOLICYNO);
                                    agen.PHOLDER = bacaString(ambilGI.PolicyDetailsGI[i].PHOLDER);
                                    agen.CT = bacaString(ambilGI.PolicyDetailsGI[i].CT);
                                    agen.ConjunctionF = bacaString(ambilGI.PolicyDetailsGI[i].ConjunctionF);
                                    agen.Description1 = bacaString(ambilGI.PolicyDetailsGI[i].description1);
                                    agen.ID = bacaString(ambilGI.PolicyDetailsGI[i].ID);
                                    agen.Salutation = bacaString(ambilGI.PolicyDetailsGI[i].Salutation);
                                    agen.FirstName = bacaString(ambilGI.PolicyDetailsGI[i].FirstName);
                                    agen.MidName = bacaString(ambilGI.PolicyDetailsGI[i].MidName);
                                    agen.LastName = bacaString(ambilGI.PolicyDetailsGI[i].LastName);
                                    agen.Name2 = bacaString(ambilGI.PolicyDetailsGI[i].Name2);
                                    agen.Email1 = bacaString(ambilGI.PolicyDetailsGI[i].Email);
                                    agen.Email_2 = bacaString(ambilGI.PolicyDetailsGI[i].Email_2);
                                    agen.Title = bacaString(ambilGI.PolicyDetailsGI[i].Title);
                                    
                                    system.debug('Agent Name: '+agen.AgentName+', Agent ID' +agen.AgentID);
                                }    
                                
                                //GI Claim
                                string policyno = bacaString(ambilGI.PolicyDetailsGI[i].POLICYNO);
                                string claimregno = bacaString(ambilGI.PolicyDetailsGI[i].CLAIMREGNO);
                                string claim_stsdesc = bacaString(ambilGI.PolicyDetailsGI[i].CLAIM_STSDESC);
                                string brchcode = bacaString(ambilGI.PolicyDetailsGI[i].BRCHCODE);
                                string clientname = bacaString(ambilGI.PolicyDetailsGI[i].CLIENTNAME);
                                string description_claim = bacaString(ambilGI.PolicyDetailsGI[i].DESCRIPTION_CLAIM);
                                string accidentplace = bacaString(ambilGI.PolicyDetailsGI[i].ACCIDENTPLACE);
                                string repairername = bacaString(ambilGI.PolicyDetailsGI[i].REPAIRERNAME);
                                string driver_name = bacaString(ambilGI.PolicyDetailsGI[i].DRIVER_NAME);
                                string notification_date = bacaString(ambilGI.PolicyDetailsGI[i].NOTIFICATION_DATE);
                                string dateofloss = bacaString(ambilGI.PolicyDetailsGI[i].DATEOFLOSS);
                                string approval_payment = bacaString(ambilGI.PolicyDetailsGI[i].APPROVAL_PAYMENT);
                                string payment_date = bacaString(ambilGI.PolicyDetailsGI[i].PAYMENT_DATE);
                                string registrationdate = bacaString(ambilGI.PolicyDetailsGI[i].REGISTRATIONDATE);
                                
                                val1 = policyno.trim()+'::'+claimregno.trim()+'::'+claim_stsdesc.trim()+'::'+brchcode.trim()+'::'+description_claim.trim()+'::'+
                                       clientname.trim()+'::'+notification_date.trim()+'::'+registrationdate.trim()+'::'+dateofloss.trim()+'::'+approval_payment.trim()+'::'+
                                       payment_date.trim()+'::'+accidentplace.trim()+'::'+repairername.trim()+'::'+driver_name.trim();
                                
                                system.debug('Val1: ' +val1);
                                
                                if(temp1 != val1){
                                    GIClaim claim = new GIClaim();
                                    claim.PolicyNo = policyno;
                                    claim.ClaimRegNo = claimregno;
                                    claim.ClaimStatus = claim_stsdesc;
                                    claim.Branch = brchcode;
                                    claim.ClientName = clientname;
                                    claim.Description = description_claim;
                                    claim.AccidentPlace = accidentplace;
                                    claim.RepairShop = repairername;
                                    claim.DriverName = driver_name;
                                    try{
                                        if(notification_date.trim() != '' && notification_date.trim() != '0' && notification_date.trim() != '00000000'){
                                            claim.NotifDate = convertStringToDate(notification_date);
                                        }
                                        else{
                                            claim.NotifDate = null;
                                        }
                                        if(dateofloss.trim() != '' && dateofloss.trim() != '0' && dateofloss.trim() != '00000000'){
                                            claim.DateofLoss = convertStringToDate(dateofloss);
                                        }
                                        else{
                                            claim.DateofLoss = null;
                                        }
                                        if(approval_payment.trim() != '' && approval_payment.trim() != '0' && approval_payment.trim() != '00000000'){
                                            claim.ApprPayDate = convertStringToDate(approval_payment);
                                        }
                                        else{
                                            claim.ApprPayDate = null;
                                        }
                                        if(payment_date.trim() != '' && payment_date.trim() != '0' && payment_date.trim() != '00000000'){
                                            claim.PaymentDate = convertStringToDate(payment_date);
                                        }
                                        else{
                                            claim.PaymentDate = null;
                                        }
                                        if(registrationdate.trim() != '' && registrationdate.trim() != '0' && registrationdate.trim() != '00000000'){
                                            claim.RegDate = convertStringToDate(registrationdate);
                                        }
                                        else{
                                            claim.RegDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured: '+e.getMessage());
                                    }
                                    giClaimList.add(claim);    
                                    temp1 = val1;
                                }           
                                
                                //GI Endorsement
                                string certificationno_ender = bacaString(ambilGI.PolicyDetailsGI[i].CERTIFICATENO_ENDOR);
                                string contract_type = bacaString(ambilGI.PolicyDetailsGI[i].CONTRACT_TYPE);
                                string endorsment = bacaString(ambilGI.PolicyDetailsGI[i].ENDORSMENT);
                                string status = bacaString(ambilGI.PolicyDetailsGI[i].STATUS);
                                string type_endor = bacaString(ambilGI.PolicyDetailsGI[i].TYPE_ENDOR);
                                String inforce_date = bacaString(ambilGI.PolicyDetailsGI[i].INFORCE_DATE);
                                string start_date = bacaString(ambilGI.PolicyDetailsGI[i].START_DATE);
                                string end_date = bacaString(ambilGI.PolicyDetailsGI[i].END_DATE);
                                
                                val2 = policyno.trim()+'::'+certificationno_ender.trim()+'::'+contract_type.trim()+'::'+
                                       inforce_date.trim()+'::'+start_date.trim()+'::'+end_date.trim()+'::'+
                                       endorsment.trim()+'::'+status.trim()+'::'+type_endor.trim();
                                
                                system.debug('Val2: ' +val2);
                                
                                if(temp2 != val2){
                                    GIEndorsement endorse = new GIEndorsement();
                                    endorse.PolicyNo = policyno;
                                    endorse.CertificateNo = certificationno_ender;
                                    endorse.ContractType = contract_type;
                                    endorse.EndorsementRemark = endorsment;
                                    endorse.Status = status;
                                    endorse.TypeGI = type_endor;
                                    try{
                                        if(inforce_date.trim() != '' && inforce_date.trim() != '0' && inforce_date.trim() != '00000000'){
                                            endorse.InforceDate = convertStringToDate(inforce_date);
                                        }
                                        else{
                                            endorse.InforceDate = null;
                                        }
                                        if(start_date.trim() != '' && start_date.trim() != '0' && start_date.trim() != '00000000'){
                                            endorse.StartDate = convertStringToDate(start_date);
                                        }
                                        else{
                                            endorse.StartDate = null;
                                        }
                                        if(end_date.trim() != '' && end_date.trim() != '0' && end_date.trim() != '00000000'){
                                            endorse.EndDate = convertStringToDate(end_date);
                                        }
                                        else{
                                            endorse.EndDate = null;
                                        }
                                    }catch(Exception e){
                                        system.debug('Error has occured in Endorsement dates: '+e.getMessage());
                                    }
                                    giEndorsementList.add(endorse);    
                                    temp2 = val2;
                                }
                                
                                //Table of Content
                                string tblList1 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC1);
                                string tblList2 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC2);
                                string tblList3 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC3);
                                string tblList4 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC4);
                                string tblList5 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC5);
                                string tblList6 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC6);
                                string tblList7 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC7);
                                string tblList8 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC8);
                                string tblList9 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC9);
                                string tblList10 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC10);
                                string tblList11 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC11);
                                string tblList12 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC12);
                                string tblList13 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC13);
                                string tblList14 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC14);
                                string tblList15 = bacaString(ambilGI.PolicyDetailsGI[i].VALUEDESC15);
                                
                                val3 = tblList1.trim()+'::'+tblList2.trim()+'::'+tblList3.trim()+'::'+tblList4.trim()+'::'+tblList5.trim()+'::'+
                                       tblList6.trim()+'::'+tblList7.trim()+'::'+tblList8.trim()+'::'+tblList9.trim()+'::'+tblList10.trim()+'::'+
                                       tblList11.trim()+'::'+tblList12.trim()+'::'+tblList13.trim()+'::'+tblList14.trim()+'::'+tblList15.trim();
                                
                                system.debug('Val3: ' +val3);
                                
                                if(temp3 != val3){
                                    TableofContent toc = new TableofContent();
                                    
                                    if(tblList1 != '' && tblList1 != ';'){
                                        toc.tableLabel1 = tblList1.substring(0, tblList1.indexOf(';'));
                                        toc.tableValue1 = tblList1.substring(tblList1.indexOf(';')+1, tblList1.length());
                                    }
                                    if(tblList2 != '' && tblList2 != ';'){
                                        toc.tableLabel2 = tblList2.substring(0, tblList2.indexOf(';'));
                                        toc.tableValue2 = tblList2.substring(tblList2.indexOf(';')+1, tblList2.length());
                                    }
                                    if(tblList3 != '' && tblList3 != ';'){
                                        toc.tableLabel3 = tblList3.substring(0, tblList3.indexOf(';'));
                                        toc.tableValue3 = tblList3.substring(tblList3.indexOf(';')+1, tblList3.length());
                                    }
                                    if(tblList4 != '' && tblList4 != ';'){
                                        toc.tableLabel4 = tblList4.substring(0, tblList4.indexOf(';'));
                                        toc.tableValue4 = tblList4.substring(tblList4.indexOf(';')+1, tblList4.length());
                                    }
                                    if(tblList5 != '' && tblList5 != ';'){
                                        toc.tableLabel5 = tblList5.substring(0, tblList5.indexOf(';'));
                                        toc.tableValue5 = tblList5.substring(tblList5.indexOf(';')+1, tblList5.length());
                                    }
                                    if(tblList6 != '' && tblList6 != ';'){
                                        toc.tableLabel6 = tblList6.substring(0, tblList6.indexOf(';'));
                                        toc.tableValue6 = tblList6.substring(tblList6.indexOf(';')+1, tblList6.length());
                                    }
                                    if(tblList7 != '' && tblList7 != ';'){
                                        toc.tableLabel7 = tblList7.substring(0, tblList7.indexOf(';'));
                                        toc.tableValue7 = tblList7.substring(tblList7.indexOf(';')+1, tblList7.length());
                                    }
                                    if(tblList8 != '' && tblList8 != ';'){
                                        toc.tableLabel8 = tblList8.substring(0, tblList8.indexOf(';'));
                                        toc.tableValue8 = tblList8.substring(tblList8.indexOf(';')+1, tblList8.length());
                                    }
                                    if(tblList9 != '' && tblList9 != ';'){
                                        toc.tableLabel9 = tblList9.substring(0, tblList9.indexOf(';'));
                                        toc.tableValue9 = tblList9.substring(tblList9.indexOf(';')+1, tblList9.length());
                                    }
                                    if(tblList10 != '' && tblList10 != ';'){
                                        toc.tableLabel10 = tblList10.substring(0, tblList10.indexOf(';'));
                                        toc.tableValue10 = tblList10.substring(tblList10.indexOf(';')+1, tblList10.length());
                                    }
                                    if(tblList11 != '' && tblList11 != ';'){
                                        toc.tableLabel11 = tblList11.substring(0, tblList11.indexOf(';'));
                                        toc.tableValue11 = tblList11.substring(tblList11.indexOf(';')+1, tblList11.length());
                                    }
                                    if(tblList12 != '' && tblList12 != ';'){
                                        toc.tableLabel12 = tblList12.substring(0, tblList12.indexOf(';'));
                                        toc.tableValue12 = tblList12.substring(tblList12.indexOf(';')+1, tblList12.length());
                                    }
                                    if(tblList13 != '' && tblList13 != ';'){
                                        toc.tableLabel13 = tblList13.substring(0, tblList13.indexOf(';'));
                                        toc.tableValue13 = tblList13.substring(tblList13.indexOf(';')+1, tblList13.length());
                                    }
                                    if(tblList14 != '' && tblList14 != ';'){
                                        toc.tableLabel14 = tblList14.substring(0, tblList14.indexOf(';'));
                                        toc.tableValue14 = tblList14.substring(tblList14.indexOf(';')+1, tblList14.length());
                                    }
                                    if(tblList15 != '' && tblList15 != ';'){
                                        toc.tableLabel15 = tblList15.substring(0, tblList15.indexOf(';'));
                                        toc.tableValue15 = tblList15.substring(tblList15.indexOf(';')+1, tblList15.length());
                                    }
                                    TOCList.add(toc);
                                    temp3 = val3;
                                }
                                
                                //Interest Info
                                string add_cover_code = bacaString(ambilGI.PolicyDetailsGI[i].Add_Cover_Code);
                                string add_cover_name = bacaString(ambilGI.PolicyDetailsGI[i].Add_Cover_Name);
                                string add_cover_type = bacaString(ambilGI.PolicyDetailsGI[i].Add_Cover_Type);
                                string add_cover_premium = bacaString(ambilGI.PolicyDetailsGI[i].Add_Cover_Premium);
                                string sum_insured_of_add_cover = bacaString(ambilGI.PolicyDetailsGI[i].Sum_Insured_Of_Add_Cover);
                                
                                val4 = add_cover_code.trim()+'::'+add_cover_name.trim()+'::'+add_cover_type.trim()+'::'+
                                       add_cover_premium.trim()+'::'+sum_insured_of_add_cover.trim();
                                
                                system.debug('Val4: ' +val4);
                                
                                if(temp4 != val4){
                                    InterestInfo intrstInfo = new InterestInfo();
                                    intrstInfo.AddCoverCode = add_cover_code;
                                    intrstInfo.AddCoverName = add_cover_name;
                                    intrstInfo.AddCoverType = add_cover_type;
                                    if(add_cover_premium != null && add_cover_premium.trim() != ''){
                                        intrstInfo.AddCoverPremium = decimal.valueOf(double.valueOf(add_cover_premium));
                                    }
                                    else{
                                        intrstInfo.AddCoverPremium = 0;
                                    }
                                    if(sum_insured_of_add_cover != null && sum_insured_of_add_cover.trim() != ''){
                                        intrstInfo.SIofAddCover = decimal.valueOf(double.valueOf(sum_insured_of_add_cover));
                                    }
                                    else{
                                        intrstInfo.SIofAddCover = 0;
                                    }
                                    interestInfoList.add(intrstInfo);    
                                    temp4 = val4;
                                }
                                system.debug('Finish for GI....');
                                system.debug('Return from WSDL/DESRTN: ' +errorDSRTN);      
                            }
                        }
                    }
                    //updateContactMagi(contactId, polisRider.StartDate, polisRider.Segment, polisRider.Branch);
                }catch(Exception e){
                    system.debug('Return from WSDL: ' +errorDSRTN);
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
            applogScreen.policy_no__c = contactRec.policy_no__c;

            applogWS.Policy_App__c = contactRec.PolicyApp__c; 
            applogWS.entity__c = contactRec.Entity__c;
            applogWS.policy_no__c = contactRec.policy_no__c;
            //applogScreen.end_date__c = system.now();
            applogScreen.EndLongTime__c = system.now().getTime();
    
            logList.add(applogws);
            logList.add(applogScreen);
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