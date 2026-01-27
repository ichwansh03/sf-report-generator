public class CheckClaimStatus {
    @future(callout=true)
    public static void checkClaimSts(String emailLogId){
        
        String claimNo = '';
        String suspicious = '';
        Boolean getDataSuccess = false;
        
        system.debug('CheckClaimStatus');
        
        DescribeSObjectResult describeResult = Email_SMS_Log__c.getSObjectType().getDescribe();
        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
        String fieldStr = String.join(fieldList, ',');
        String query = ' SELECT ' + fieldStr + ', case__r.Case_Type_Config__c, case__r.Case_type__c, case__r.MOT__c, case__r.entity__c, case__r.Follow_Up_ICF__c, contact__r.MobilePhone,case__r.Subject FROM Email_SMS_Log__c WHERE Id = :emailLogId ';
        
        Email_SMS_Log__c log = Database.query(query); 
        
        String contactIds = log.Contact__c;  
        Boolean isEligible = true; 
        if(log.Case__r.Case_type__c == 'Request_Claim_Payment'){
            //check eligible to EIP
            string infoDescription = '';
            String recordName = log.case__r.Subject;
            claimNo = recordName.replaceAll('[^0-9]', '');
            log.Claim_Number__c = claimNo;
            Contact ctc = [select id, policy_no__c, entity__c, policyApp__c //add for sprint 2 ICF
                           from contact where id =: contactIds limit 1];
            String policyStatusCD = '';
            String PSOURCE = '';
            String assmtTypeCd = '';
            String policyApp = ctc.policyApp__c;
            //get data from EIP
            EIPJson dataPolicyEIP, dataClaimAss, dataFraud;
            try{
                
                if(ctc.PolicyApp__c == 'DMTM') {
                    policyApp = 'DMTM_REST_V3';
                }
                else{
                    if (!System.test.isrunningtest() ){
                        dataClaimAss = EIPConnector.getAssNotes('Summary', ctc.entity__c, ctc.policyApp__c, ctc.policy_no__c, 'CLM', '', '', false);
                        assmtTypeCd = dataClaimAss.Body.AgSa_InsurancePolicy_Type.hasPolicyAssessmentDetailsIn[0].assmtTypeCd;
                    }
                }
                if (!System.test.isrunningtest() ){
                    dataPolicyEIP = EIPConnector.getPolicyDetails('Policy Details', ctc.entity__c, ctc.policyApp__c, ctc.policy_no__c);
                    dataFraud = EIPConnector.getPolicyFraud('getFraudMaintenance', ctc.entity__c, policyApp, ctc.policy_no__c, claimNo);
                }
                getDataSuccess = true;
            }
            catch(EIPConnector.NoDataException e){
                System.debug('NoDataException'+ e); 
            }catch(EIPConnector.EIPConnectorException e){
                System.debug('NoDataException'+ e); 
            }catch(Exception e){
                System.debug('NoDataException'+ e); 
            } 
            
            if(!getDataSuccess){
                isEligible = false;
                log.Status__c = 'Draft EIP';
                log.EIP_Response__c = 'Data Not Available from EIP';
            }else{
                if (!System.test.isrunningtest() ){
                    policyStatusCD = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyStatusCD;
                    PSOURCE = dataPolicyEIP.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].sourceChannelCD;
                }
                else{
                    suspicious = 'ABC';
                    policyStatusCD = '[4] LAPSED (NON-CV PLAN)';
                    PSOURCE = '';
                    assmtTypeCd = 'HOSP DEATH';
                }
                log.EIP_Response__c = 'Get Data Success';
            }
            
            if(policyStatusCD != null && policyStatusCD != ''){
                if(label.Claim_Policy_Sts_Inactive.contains(policyStatusCD)){
                    log.Claim_Policy_Status__c = 'INACTIVE';
                    isEligible = false;
                    infoDescription = 'Policy Status: Inactive';
                } 
                if(label.Claim_Policy_Sts_Accept.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'ACCEPTED';
                if(label.Claim_Policy_Sts_Inforce.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'IN_FORCE';
                if(label.Claim_Policy_Sts_Open.contains(policyStatusCD)) log.Claim_Policy_Status__c = 'OPENED';
                log.Claim_Policy_Status_ICF__c = policyStatusCD;
            }
            if(PSOURCE != null && PSOURCE != '') log.Claim_Policy_Priority__c = PSOURCE.contains('PCC') ? 'Priority' : 'Non-Priority';
            log.Claim_Type__c = assmtTypeCd;
            
            if(assmtTypeCd.contains('DEATH')){
                isEligible = false;
                infoDescription = 'Claim Type : Death';
            }
            if (!System.test.isrunningtest() ){
                if(dataFraud.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].customerRk == null){
                    suspicious = '';
                }
                else{
                    suspicious = dataFraud.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].customerRk;
                    log.Claim_Suspicious__c = suspicious;
                }
            }
            if(suspicious == '' || label.ICF_Non_Suspicious.contains(suspicious)){
                log.Claim_Susp_Fraud__c = 'NS';
            } else{
                log.Claim_Susp_Fraud__c = 'S';
                isEligible = false;
                infoDescription = 'Claim Suspicious: '+ suspicious;
            }
            log.is_Eligible__c = isEligible;
            update log;
        }
        
    }
    
    public class checkStatus implements Queueable {
        private Set<id> logIds;  
        public checkStatus(Set<id> logIds) {
            this.logIds = logIds; 
        }
        
        public void execute(QueueableContext context) {
            // Perform the callout asynchronously
            for (string logId : logIds) { 
                checkClaimSts(logId); 
            }
        } 
    } 
}