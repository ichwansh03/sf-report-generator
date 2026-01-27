global class BatchUpdateNoTelpTelUW implements Database.Batchable<sObject>, Database.Stateful,Database.AllowsCallouts {
    global Integer recordsProcessed = 0;
    global String query;
    global List<Contact> listContact = new List<Contact>();
    
    global List<String> listPolicyNumber= new List<String>();
    global String appID;
    
    global String strPolicyNumber='';
    global Integer hit=0;
    
    global EIPJson eipJson = new EIPJson();
    
    global List<Contact> updatedContact = new List<Contact>();
    
    global BatchUpdateNoTelpTelUW(List<String> listPolicyNumber){
        System.debug('LIST POLICY NUMBER: '+listPolicyNumber);
        this.listPolicyNumber = listPolicyNumber;
       
        strPolicyNumber = '(';
        hit=0;
        if(listPolicyNumber.size()>0){
            for(String str:listPolicyNumber){
                hit++;
                strPolicyNumber = strPolicyNumber+'\''+str+'\'';
                if(hit<listPolicyNumber.size()){
                  strPolicyNumber+= ',';  
                }else{
                    strPolicyNumber+=')';
                } 
            }
            
        }
        
        System.debug('strPolicyNumber: '+strPolicyNumber);
        
        String q = Label.query_batchUpdateNoTelpTelUW+strPolicyNumber;
        this.query=q;
        system.debug(LoggingLevel.DEBUG,'*query*'+q);
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> listContact){
        System.debug('listContact: '+listContact.size());

        for(Contact c: listContact){
            System.debug('CONTACT: '+c.Policy_No__c+','+c.PolicyApp__c);
            appID = c.PolicyApp__c;
            
            
            eipJson = EIPConnector.getPolicyDetails(EIPConstant.OPERATION_APP_DETAIL, EIPConstant.ENTITY_AMFS, appID, c.Policy_No__c);
            
            System.debug('eipJson: '+eipJson.Body.IcAx_AXAAsiaCustomer_Type);
            
            if(eipJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyNO == c.Policy_No__c && eipJson.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO != '                    '){
                System.debug('POLICY NO: '+eipJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyNO+' EIP MOBILE PHONE: '+ eipJson.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO);
                c.MobilePhone = eipJson.Body.IcAx_AXAAsiaCustomer_Type.canBeIndividual.hasAddressesIn[0].mobilePhoneNO;
                System.debug('POLICY NO: '+eipJson.Body.IcAx_AXAAsiaCustomer_Type.hasPolicyAccount[0].policyNO+' NEW CONTACT MOBILE PHONE : '+c.MobilePhone+' Campaign Type: '+c.Campaign_Type__c);
                
                //reset data
        
                //c.MobilePhone='1234567890';
                updatedContact.add(c);
                recordsProcessed++;
            }else{
                System.debug('DATA NOT FOUND');
            }
        }
        
        update updatedContact;
    }
    
    
    global void finish(Database.BatchableContext bc){
        System.debug(LoggingLevel.DEBUG, '***TOTAL PROCESSED: ' + recordsProcessed);
        for(Contact c: updatedContact){
            System.debug('UPDATED CONTACT: '+c.Policy_No__c);
        }
    }
}