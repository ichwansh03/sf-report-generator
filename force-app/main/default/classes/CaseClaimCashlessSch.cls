global with sharing class CaseClaimCashlessSch implements Schedulable, Database.Batchable<String>, Database.AllowsCallouts {
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new CaseClaimCashlessSch(), 50);
    }
    
    global Iterable<String> start(Database.BatchableContext bc){
        EIPJson claimdetails;
        Map<String,String> properties = new Map<String, String>();
        Datetime dt = DateTime.now().addDays(-1); 
        //Datetime dt = DateTime.newInstance(2021, 9, 7, 10, 30, 0);
        String dateTime_start = dt.format('yyyy-MM-dd') + 'T00:00';
        String dateTime_end = dt.format('yyyy-MM-dd') + 'T23:50';
        properties.put('policyType', 'C');
        properties.put('claimTypeCode', 'IP');
        properties.put('claimStatusCode','O');
        properties.put('totalClaimAmount', '1');
        properties.put('totalApprovedAmount', '1');
        properties.put('firstApprovalDate',dateTime_start);
        properties.put('lastApprovalDate',dateTime_end);
        properties.put('pagevalue','1');
        Integer totaldata, totalloop;
        claimdetails = EIPConnector.sendCommunicationMessageTADA('claim', 'AMFS', 'AHS', properties);
        if (System.test.isrunningtest() ) {
            EIPJSON.EIP_AgSa_NameValue namevalue = new EIPJSON.EIP_AgSa_NameValue();
            namevalue.value = '1';
            namevalue.name = 'totalRecordData';
            
            List<EIPJSON.EIP_AgSa_NameValue> list_namevalue = new List<EIPJSON.EIP_AgSa_NameValue>();
            list_namevalue.add(namevalue);
            
            EIPJSON.EIP_AgSa_InsurancePolicy hasPolicyAccount = new EIPJSON.EIP_AgSa_InsurancePolicy();
            hasPolicyAccount.hasNameValue = list_namevalue;
            
            List<EIPJSON.EIP_AgSa_InsurancePolicy> list_hasPolicyAccount = new List<EIPJSON.EIP_AgSa_InsurancePolicy>();
            list_hasPolicyAccount.add(hasPolicyAccount);
            
            EIPJSON.EIP_IcAx_AXAAsiaCustomer customer = new EIPJSON.EIP_IcAx_AXAAsiaCustomer();
            customer.hasPolicyAccount = list_hasPolicyAccount;
            
            EIPJSON.EIP_Body body = new EIPJSON.EIP_Body();
            body.IcAx_AXAAsiaCustomer_Type = customer;
            
            EIPJson test = new EIPJson();
            test.Body = body;
            
            claimdetails = test;
           
        }
            if(claimdetails != null){
                Integer namevalue = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasNameValue == null ? 0 : claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasNameValue.size();
                if(namevalue > 0){
                    for (Integer i = 0; i < namevalue; i++) {
                        if(claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasNameValue[i].name == 'totalRecordData'){
                            totaldata = Integer.valueOf(claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasNameValue[i].value);
                            if (totaldata > 10) totalloop = totaldata / 10 + 1;
                            else totalloop = 1;
                        }
                    }
                }
                
            }
        
        List<String> data = new List<String> ();
        for (Integer k = 0; k < totalloop; k++) {
            data.add(String.valueof(k+1));
        }
        system.debug('Size:'+data.size());
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<String> data){ 
        EIPJson claimdetails;
        Map<String,String> properties = new Map<String, String>();
        Datetime dt = DateTime.now().addDays(-1); 
        //Datetime dt = DateTime.newInstance(2021, 9, 7, 10, 30, 0);
        String dateTime_start = dt.format('yyyy-MM-dd') + 'T00:00';
        String dateTime_end = dt.format('yyyy-MM-dd') + 'T23:50';
        properties.put('policyType', 'C');
        properties.put('claimTypeCode', 'IP');
        properties.put('claimStatusCode','O');
        properties.put('totalClaimAmount', '1');
        properties.put('totalApprovedAmount', '1');
        properties.put('firstApprovalDate',dateTime_start);
        properties.put('lastApprovalDate',dateTime_end);
        for(String d:data){
            properties.put('pagevalue',d);
            claimdetails = EIPConnector.sendCommunicationMessageTADA('claim', 'AMFS', 'AHS', properties);
            if (System.test.isrunningtest() ) {
                EIPJSON.EIP_PnCClaim_CLAIM hasPnCClaimIn = new EIPJSON.EIP_PnCClaim_CLAIM();
                hasPnCClaimIn.claimNumber = '1234';
                hasPnCClaimIn.claimStatusCode = 'test';
                hasPnCClaimIn.claimStatusDesc = 'test';
                hasPnCClaimIn.providerNetworkCode = 'test';
                hasPnCClaimIn.policyNumber = 'test';
                
                List<EIPJSON.EIP_PnCClaim_CLAIM> list_hasPnCClaimIn = new List<EIPJSON.EIP_PnCClaim_CLAIM>();
                list_hasPnCClaimIn.add(hasPnCClaimIn);
                
                EIPJSON.EIP_AgSa_InsurancePolicy hasPolicyAccount = new EIPJSON.EIP_AgSa_InsurancePolicy();
                hasPolicyAccount.hasPnCClaimIn = list_hasPnCClaimIn;
                
                List<EIPJSON.EIP_AgSa_InsurancePolicy> list_hasPolicyAccount = new List<EIPJSON.EIP_AgSa_InsurancePolicy>();
                list_hasPolicyAccount.add(hasPolicyAccount);
                
                EIPJSON.EIP_IcAx_AXAAsiaCustomer customer = new EIPJSON.EIP_IcAx_AXAAsiaCustomer();
                customer.hasPolicyAccount = list_hasPolicyAccount;
                
                EIPJSON.EIP_Body body = new EIPJSON.EIP_Body();
                body.IcAx_AXAAsiaCustomer_Type = customer;
                
                EIPJson test = new EIPJson();
                test.Body = body;
                
                claimdetails = test;
                
            }
            List<ICF_Claim_Approve__c> list_claims = new List<ICF_Claim_Approve__c>();
            if(claimdetails != null){
                Integer totalData = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn == null ? 0 : claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn.size();
                for (Integer i = 0; i < totalData; i++) {
                    ICF_Claim_Approve__c claims = new ICF_Claim_Approve__c();
                    claims.Approve_Date__c = dt.date();
                    claims.Claim_Number__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[i].claimNumber;
                    claims.Claim_Status_Code__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[i].claimStatusCode;
                    claims.Claim_Status_Desc__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[i].claimStatusDesc;
                    claims.Nama_Rumah_Sakit__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[i].providerNetworkCode;
                    claims.Policy_Number__c = claimdetails.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].hasPnCClaimIn[i].policyNumber;
                    claims.Proceed_ICF__c = false; 
                    list_claims.add(claims);
                }
            }
            insert list_claims;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
    
    
}