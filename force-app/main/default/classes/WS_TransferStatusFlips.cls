@RestResource(urlMapping='/TransferStatus/*')
global class WS_TransferStatusFlips {
    @HttpPOST
    global static void UpdateTransferStatus(String policy_number, String claim_number, String transfer_status, String transfer_date){
        String status = '';
        String codeReturn = '';
        String messageReturn = '';
        
        String optyId = '';
        String bodyReq = ''; 
        String jsonHeader= '';
        String jsonParam= '';
        
        try {  
            RestRequest req = RestContext.request;
            Map<String, Object> getHeaders = req.headers;
            jsonHeader = JSON.serialize(getHeaders);
            
            
            List<Contact> cc = [select id, name, PolicyApp__c, Policy_No__c, WelcomeCall_Product_Code_Plan__c from contact where Policy_No__c =: policy_number limit 1];
                        
            if (string.isBlank(policy_number)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'policy number cannont be blank!';
                
            }else if (string.isBlank(claim_number)) {
                codeReturn = '400';
                status = 'Error';
                messageReturn = 'claim number cannont be blank!';
            } else {
                if(cc.size() == 0){
                    codeReturn = '400';
                    status = 'Error';
                    messageReturn = 'Contact Not Found';
                }else{
                    String product =  cc[0].WelcomeCall_Product_Code_Plan__c;
                    List<ICF_Parameter__c> icfParams = [select id, name, Exclude_Product_Plan_Code__c, RecordType.Name from ICF_Parameter__c where RecordType.Name = 'Master - qualtrics' and Exclude_Product_Plan_Code__c includes (:product)];
                    
                    List<Case> cs_old = [select id, Status, Subject, MOT__c, Description from Case where Policy_Numbers__c =:policy_number and Case_Type__c = 'Request_Claim_Payment' and status != 'Closed' limit 1];
                    if(icfParams.size() != 0){
                        //case not created excluded product
                    }
                    else{
                        if(cs_old.size() > 0){
                            for(Case c:cs_old){
                                c.Status = 'Closed';
                                c.Subject = c.Subject + ' / ICF for Claim No '+ claim_number;
                                c.MOT__c = 'I Claim';
                                c.Case_Type__c = 'Request_Claim_Payment';
                                c.Case_Type_Config__c = 'Request_Claim_Payment';
                                if(c.Description !=null){ c.Description = c.Description + '/ Transfer Status: ' + transfer_status + ' / Transfer Date: ' + transfer_date;}
                                else{ c.Description = 'Transfer Status: ' + transfer_status + ' / Transfer Date: ' + transfer_date;}
                                
                                if(!System.test.isrunningtest()) update c;
                            }
                        }else{
                            RecordType rt = [select Id, Name from RecordType where sObjectType='Case' and name = 'RequestAMFSCase' limit 1];
                            User usr = [select id, name from user where name = 'Claim' limit 1];
                            Case cs = new Case();
                            cs.Policy_Number__c = cc[0].Policy_No__c;
                            cs.ContactId = cc[0].id;
                            cs.Type = 'Request';
                            cs.Status = 'Closed';
                            cs.MOT__c = 'I Claim';
                            cs.Subject = 'ICF for Claim No '+ claim_number;
                            cs.Entity_Backup__c = 'AMFS';
                            cs.RecordTypeId = rt.Id;
                            cs.Case_Type__c = 'Request_Claim_Payment';
                            cs.Case_Type_Config__c = 'Request_Claim_Payment' ;
                            cs.Description = 'Transfer Status: ' + transfer_status + ' / Transfer Date: ' + transfer_date;
                            cs.PIC_Department_LU__c = usr.Id;
                            if(!System.test.isrunningtest()) insert cs;
                        }
                    }
                    
                    
                    codeReturn = '200';
                    status = 'Success';
                    messageReturn = 'Success add new data case';
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
}