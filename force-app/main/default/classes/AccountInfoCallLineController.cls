public class AccountInfoCallLineController {
    public Call_line__c cl {get;set;}
    public Contact ct {get;set;}
    public List<AccountDetail> accountDetailList {get;set;}
    public String errMsg {get;set;}
    
    
    public AccountInfoCallLineController(ApexPages.StandardController controller) {
        cl = (Call_Line__c)controller.getRecord();
        cl = [Select id, name, contact__c, contact__r.mdmid_owner__c, contact__r.Policy_No__c from Call_Line__c where id =: cl.id];
        ct = [Select Id, Policy_No__c, mdmid_owner__c, Entity__c, PolicyApp__c From Contact where ID =: cl.contact__c];
        accountDetailList = getAccountInfoViaEIP(ct);
    }
    
    public List<AccountDetail> getAccountInfoViaEIP(Contact contact){
        List<AccountDetail> accountDetailListEIP =  new List<AccountDetail>();
        try{
            String operation = (contact.PolicyApp__c == EIPConstant.APP_RLS) ? EIPConstant.OPERATION_ACCOUNT_DETAIL : EIPConstant.OPERATION_GET_ACCOUNT_DETAIL;
            EIPJson accountInfoEIP = EIPConnector.getCustomerInfo(operation, contact.Entity__c, contact.PolicyApp__c, contact.Policy_No__c);
            
            for(EIPJson.EIP_IcAx_AXAAsiaParty hasPartyDetailsIn : accountInfoEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPartyDetailsIn){
                AccountDetail accountDetail = new AccountDetail();
                
                accountDetail.AccountNo = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountNO;
                String fullAccountName = '';
                if(String.isNotBlank(hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM)){
                    fullAccountName += hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.payorFirstNM + ' ';
                }
                if(String.isNotBlank(hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM)){
                    fullAccountName += hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.payorLastNM;
                }
                accountDetail.AccountName = fullAccountName.trim();
                accountDetail.AccountEffectiveDate = (hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountEffectiveDT != null) ? CCCUtils.strToDate(hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountEffectiveDT, 'yyyymmdd') : null;
                accountDetail.AccountExpiredDate = (hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountExpirationDT != null) ? CCCUtils.strToDate(hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountExpirationDT, 'ddyyyymm'): null;
                accountDetail.AccountType = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountTypeCD;
                accountDetail.AccountStatus = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.accountStatusCD;
                accountDetail.CollectionBank = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.bankName;
                accountDetail.Branch = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.branchCD;
                accountDetail.RejectCode = hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.rejectCD;
                accountDetail.RejectDate = (hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.rejectDT != null) ? CCCUtils.strToDate(hasPartyDetailsIn.canBeIndividual.hasPartyAccountDetailsIn.rejectDT, 'yyyymmdd'):null;
                accountDetailListEIP.add(accountDetail);
            }
        }catch(Exception ex){
            system.debug('ERROR when get account info : ' + ex);
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Ada masalah ketika pengambilan data, silahkan hubungi Admin.'));
        }
        return accountDetailListEIP;
    }
    
    public class AccountDetail{
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
}