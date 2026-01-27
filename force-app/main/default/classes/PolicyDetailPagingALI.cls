public class PolicyDetailPagingALI {
    Public String idparam {get;set;}
    public integer index {get;set;}
    public integer blockSize {get;set;}
    public integer totalRecs {get;set;}
    public integer totalAllRecs {get;set;}
    public Boolean fetchCalled;
    Public String filcampname {get;set;}
    Public String filcallstatus {get;set;}
    PUBLIC String SOQL {get;set;}
    public Boolean AdditionalNonRLS {get;set;}
    public Boolean PaymentView {get;set;}
    public Boolean CallNoteView {get;set;}
    public Boolean ClaimView {get;set;}
    public Boolean PolicyHistoryView {get;set;}
    
    public PolicyRider polisRider {get;set;}
    Public List<BackEndPaging__c> ListBEP {get;set;}
    Public List<BackEndPaging__c> trxBackEndRHSList {get;set;}
    Public List<BackEndPaging__c> trxPaymentList {get;set;}
    Public List<BackEndPaging__c> TrxPolicyHistoryList {get;set;}
    Public List<BackEndPaging__c> trxClaimList {get;set;}
    Public List<BackEndPaging__c> trxOpenLastClaimList {get;set;}

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

        public decimal TotalNotPaid {get; set;}
        public integer CountPayment {get; set;}
        public integer CountPaid {get; set;}
        public integer CountNotPaid {get; set;}

        public string Entity  {get; set;}        
        public string PolicyNo  {get; set;}        
        public string PolicyApp  {get; set;}        
        public string Name  {get; set;}        
        public string InsuredName  {get; set;}        

        public PolicyRider(){
        }       
    }    
    
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
    public void toggleSort() {
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    }
    public String sortField {
        get  { if (sortField == null) {sortField = 'Createddate'; } return sortField;  }
        set;
    }
    public PolicyDetailPagingALI(){
        String DataId = ApexPages.currentPage().getParameters().get('id');
        String RecordType = ApexPages.currentPage().getParameters().get('RecordType');
        ListBEP = new List<BackEndPaging__c>();
        trxBackEndRHSList = new List<BackEndPaging__c>();
        trxPaymentList = new List<BackEndPaging__c>();
        TrxPolicyHistoryList = new List<BackEndPaging__c>();
        trxClaimList = new List<BackEndPaging__c>();
        trxOpenLastClaimList = new List<BackEndPaging__c>();
        
        polisRider = new PolicyRider(); 
        
        if(test.isRunningTest()){
        polisRider.PolicyNumber = '';
        polisRider.MataUang = '';
        polisRider.ReferenceNumber = '';
        polisRider.ProductCode = '';
        polisRider.ProductName = '';
        polisRider.PolicyStatus = '';
        polisRider.DateofApplication = date.today();
        polisRider.IssuedDate = date.today();
        polisRider.EffectiveDate = date.today();
        polisRider.ExpiredDate = date.today();
        polisRider.TerminationDate = date.today();
        polisRider.ReferenceDate = date.today();
        polisRider.TotalPremium = 10;
        polisRider.TotalSumInsured = 10;
        polisRider.Description = '';
        polisRider.TotalPremiumofBasicPlan = 10;
        polisRider.BasicSI = 10;
        polisRider.RegularTopUp = 10;
        polisRider.LumpSumTopUp = 10;
        polisRider.BasicRiderModPrem = 10;
        polisRider.BasicRegPrem = 10;
        polisRider.PaymentMethod = '';
        polisRider.PaymentMode = '';
        polisRider.DueDate1 = date.today();
        polisRider.DueDate2 = date.today();
        polisRider.PremiumHolidayStart = date.today();
        polisRider.PremiumHolidayEnd = date.today();
        polisRider.FundPrice = '';
        polisRider.CashValue = 10;
        polisRider.StatusDesc = '';
        polisRider.CoverNo = '';
        polisRider.Segment = '';
        polisRider.Branch = '';
        polisRider.BranchCode = '';
        polisRider.Insured = '';
        polisRider.StartDate = date.today();
        polisRider.EndDate = date.today();
        polisRider.CoverDate = date.today();
        polisRider.PolicyDate = date.today();
        polisRider.USPRRLTN = '';
        polisRider.TSI = 10;
        polisRider.PremiumGI = 10;
            
        polisRider.TSIS = '';
        polisRider.PremiumGIS = '';
        polisRider.AIDS = '';
                    
                    // new ALI
        polisRider.CancelDate = date.today();
        polisRider.LapseDate = date.today();
        polisRider.ReinstateDate = date.today();
        polisRider.SponsorName = '';
        polisRider.CorrespondenceTypeID = '';
        polisRider.CampaignProgramName = '';
        polisRider.CreateDate = date.today();
        polisRider.DigitaPolicyID = '';
        polisRider.AgentID = '';
            
        polisRider.TotalNotPaid = 10;
        polisRider.CountPayment = 10;
        polisRider.CountPaid = 10;
        polisRider.CountNotPaid = 10;
            
        polisRider.Entity = '';
        polisRider.PolicyNo = '';
        polisRider.PolicyApp = '';
        polisRider.Name = '';
        polisRider.InsuredName = '';
        }
        AdditionalNonRLS = TRUE;
        
        if (RecordType == 'CallNote') CallNoteView = TRUE;
        if (RecordType == 'Payment') PaymentView = TRUE;
        if (RecordType == 'PolicyHistory') PolicyHistoryView = TRUE;
        if (RecordType == 'Claim') ClaimView = TRUE;

        polisRider.MataUang = 'Rp';
        list<Contact> checkct = [SELECT id, Entity__c, Policy_No__c, Policy_No_ALI__c, PolicyApp__c FROM Contact WHERE id=:DataId];

        if (checkct.size() > 0) {
            Contact ct = [SELECT id, Entity__c, Policy_No__c, Policy_No_ALI__c, PolicyApp__c, Name, Insured_Name__c FROM Contact WHERE id=:DataId];
            polisRider.Entity = ct.Entity__c;
            polisRider.PolicyNo = ct.Policy_No_ALI__c; //ct.Policy_No__c;
            polisRider.PolicyApp = ct.PolicyApp__c;
            polisRider.Name = ct.Name;
            polisRider.InsuredName = ct.Insured_Name__c;
            
            DescribeSObjectResult describeResultdp = BackEndPaging__c.getSObjectType().getDescribe();
            List<String> dpFieldList = new List<String>(describeResultdp.fields.getMap().keySet());
            String dpFields = String.join(dpFieldList, ',');
            soql = 'SELECT '+dpFields+' FROM BackEndPaging__c where id != NULL ';
            if(ct.Entity__c !=NULL) soql = soql + ' and Entity__c='+'\''+ct.Entity__c+'\''+' ';
            if(ct.Policy_No__c !=NULL) soql = soql + ' and PolicyNo__c ='+'\''+ct.Policy_No_ALI__c+'\''+' ';
            if(ct.PolicyApp__c !=NULL) soql = soql + ' and PolicyApp__c ='+'\''+ct.PolicyApp__c+'\''+' ';
            if(ct.PolicyApp__c !=NULL) soql = soql + ' and RecordType__c ='+'\''+RecordType+'\''+' ';
    
            soql = soql + ' order by '+SortField+' '+sortDir;
            soql = soql + ' limit 40000 ';
            
            if (RecordType == 'CallNote') trxBackEndRHSList = Database.query(soql);
            if (RecordType == 'Payment') trxPaymentList = Database.query(soql);
            if (RecordType == 'PolicyHistory') TrxPolicyHistoryList = Database.query(soql);
            if (RecordType == 'Claim') trxClaimList = Database.query(soql);
            if (RecordType == 'Claim') trxOpenLastClaimList = Database.query(soql);

            polisRider.TotalNotPaid = 0;
            polisRider.CountPayment = 0;
            polisRider.CountPaid = 0;
            polisRider.CountNotPaid = 0;
        
            if (trxPaymentList.size() > 0) {
                for (BackEndPaging__c Payment : trxPaymentList) {
                    if (payment.Payment_Status__c == 'Not Paid') 
                        polisRider.TotalNotPaid += payment.Payment_Amount__c;
                }
                polisRider.CountPaid = integer.valueof(trxPaymentList[0].Payment_Count_Paid__c);
                polisRider.CountNotPaid = integer.valueof(trxPaymentList[0].Payment_Count_Not_Paid__c);
                polisRider.CountPayment = polisRider.CountPaid + polisRider.CountNotPaid;
            }

        }
  }
        
}