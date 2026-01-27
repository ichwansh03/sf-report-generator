@RestResource(urlMapping='/TransferStatusWithdrawal/*') //In Process
global class WS_TransferStatusWithdrawalFlips {
	@HttpPOST
    global static void UpdateTransferStatus(String payment_code, String policy_number, String claim_number, String transfer_status, String transfer_date){
        String status = '';
        String codeReturn = '';
        String messageReturn = '';
        
        String optyId = '';
        String bodyReq = ''; 
        String jsonHeader= '';
        String jsonParam= '';
        
        Boolean configSendDMTM = Boolean.valueof(System.Label.Config_Sent_Survey_ICF_Withdrawal_Surrender_Case_Policy_DMTM);
        
        Set<String> withdrawalPaymentCode = new Set<String>{'PC04', 'PC05', 'PC10', 'PC12'};
        
        try {  
            RestRequest req = RestContext.request;
            Map<String, Object> getHeaders = req.headers;
            jsonHeader = JSON.serialize(getHeaders);
            
            
            List<Contact> cc = [select id, name, PolicyApp__c, Policy_No__c, WelcomeCall_Product_Code_Plan__c from contact where Policy_No__c =: policy_number and Entity__c = 'AMFS' limit 1];
                        
            if (string.isBlank(payment_code)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'payment code cannont be blank!';    
            } else if (!withdrawalPaymentCode.contains(payment_code)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'Incorrect payment code!';
            } else if (string.isBlank(policy_number)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'policy number cannont be blank!';
            } else if (string.isBlank(claim_number)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'claim number cannont be blank!';
            }
            else {
                if(cc.size() == 0) {
                    codeReturn = '400';
                    status = 'Error';
                    messageReturn = 'Contact Not Found.';
                }else if(cc[0].PolicyApp__c == 'DMTM' && configSendDMTM == false){
                    codeReturn = '200';
                    status = 'Success';
                    messageReturn = 'Contact\'s Policy App is \'DMTM\'. Case will not create.';
                }else{
                    Map<String, String> caseTypeValue = getCaseTypeValue(payment_code);
                    
                    RecordType rt = [select Id, Name from RecordType where sObjectType='Case' and name = 'RequestAMFSCase' limit 1];
                    User usr = [select id, name from user where name = 'Claim' limit 1];
                    Case cs = new Case();
                    cs.Policy_Number__c = cc[0].Policy_No__c;
                    cs.ContactId = cc[0].id;
                    cs.Type = 'Request POS';
                    cs.Status = 'Closed';
                    cs.MOT__c = 'I Ask';
                    cs.Subject = 'ICF for Request POS ' + caseTypeValue.get('subject');
                    cs.Entity_Backup__c = 'AMFS';
                    cs.RecordTypeId = rt.Id;
                    cs.Case_Type__c = caseTypeValue.get('caseType');
                    cs.Case_Type_Config__c = caseTypeValue.get('caseType');
                    cs.Description = 'Transfer Status: ' + transfer_status + ' / Transfer Date: ' + transfer_date 
                        + ' / Payment Code: ' + payment_code + ' / Claim Number: ' + claim_number;
                    cs.PIC_Department_LU__c = usr.Id;
                    if(!System.test.isrunningtest()) insert cs;
                    
                    codeReturn = '200';
                    status = 'Success';
                    messageReturn = 'Success add new data case.';
                }
                
            }
            System.debug('messageReturn: ' +messageReturn);
            
        } catch(Exception ex) { 
            status = 'Internal Error';
            codeReturn = '500';
            messageReturn = ex.getMessage();
            System.debug('Get message:'+ex.getMessage());
            System.debug('Get Line:'+ex.getLineNumber());
        } 
        
        String setReturn = returnError(status,codeReturn, messageReturn);
        if(!System.Test.isRunningTest()) {
            // return response code
            RestResponse cb = RestContext.response;
            cb.addHeader('Content-Type', 'application/json');
            cb.statusCode = integer.valueOf(codeReturn);
            cb.responseBody = Blob.valueOf(setReturn);
        }
    }
    
    Public Static String returnError(String sts, String errcode, String err){
        String return_json='';
        JSONGenerator gentoken = JSON.createGenerator(true);
        gentoken.writeStartObject();
        gentoken.writeStringField('code', errcode);
        gentoken.writeStringField('status', sts);
        gentoken.writeStringField('description', err);
        gentoken.writeEndObject();
        return_json = gentoken.getAsString();
        return_json = return_json.normalizeSpace().trim();
        system.debug('*return_json*'+return_json);
        return return_json;
    }
    
    public static Map<String, String> getCaseTypeValue(String paymentCode) {
        Map<String, Map<String, String>> caseTypeMap = new Map<String, Map<String, String>>{
            'PC04' => new Map<String, String>{ 'caseType' => 'Request_POS_Withdrawal', 'subject' => 'Withdrawal' },
            'PC05' => new Map<String, String>{ 'caseType' => 'Request_POS_Redemption', 'subject' => 'Redemption' },
            'PC10' => new Map<String, String>{ 'caseType' => 'Request_POS_Surrender_Non_UL', 'subject' => 'Surrender Non UL' },
            'PC12' => new Map<String, String>{ 'caseType' => 'Request_POS_Surrender_Endowment', 'subject' => 'Surrender Endowment' }
        };
            
        return caseTypeMap.containsKey(paymentCode) ? caseTypeMap.get(paymentCode) : new Map<String, String>{};
    }
}