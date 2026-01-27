global with sharing class ClaimApproveSch implements Schedulable, Database.Batchable<sObject>{
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new ClaimApproveSch(), 1);
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        String filter = System.Label.ICF_I_Claim_Approve;
        List<ICF_Claim_Approve__c> data = new List<ICF_Claim_Approve__c> ();
        
        String query = ' SELECT Id, Policy_Number__c, Claim_Number__c, Proceed_ICF__c from ICF_Claim_Approve__c where ' + filter;
        data = Database.query(query);
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<ICF_Claim_Approve__c> list_data){ 
        List<Case> Listcase = new List<Case>();
        List<ICF_Claim_Approve__c> data_update = new List<ICF_Claim_Approve__c>();
        if(list_data.size() > 0){
            for(ICF_Claim_Approve__c data:list_data){
                try{
                    List<Contact> cc = [select id, Policy_No__c from Contact where Policy_No__c =: data.Policy_Number__c limit 1];
                    if(cc.size() > 0){
                        Case cs = new Case();
                        RecordType rt = [select Id, Name from RecordType where sObjectType='Case' and name = 'RequestAMFSCase' limit 1];
                        User usr = [select id, name from user where name = 'Claim' limit 1];
                        cs.Policy_Number__c = cc[0].Policy_No__c;
                        cs.ContactId = cc[0].id;
                        cs.Type = 'Request';
                        cs.Status = 'Closed';
                        cs.MOT__c = 'I Claim';
                        cs.Subject = 'ICF for Claim No '+ data.Claim_Number__c;
                        cs.Entity_Backup__c = 'AMFS';
                        cs.RecordTypeId = rt.Id;
                        cs.Case_Type__c = 'Request_Claim_Payment';
                        cs.Case_Type_Config__c = 'Request_Claim_Payment' ;
                        cs.Description = 'Claim Status: Cashless';
                        cs.PIC_Department_LU__c = usr.Id;
                        cs.isMassUpload__c = true;
                        insert cs;
                        String caseId = cs.Id;
                        DescribeSObjectResult describeResult = Case.getSObjectType().getDescribe();
                        List<String> fieldList = new List<String>(describeResult.fields.getMap().keySet());
                        String fieldStr = String.join(fieldList, ',');
                        String query = ' SELECT ' + fieldStr + ' FROM Case WHERE Id = :caseId ';
                        
                        Case log = Database.query(query); 
                        CreateEmailSmsLogQueue caseQueue = new CreateEmailSmsLogQueue(log);
                        System.enqueueJob(caseQueue);
                    }
                    data.Proceed_ICF__c = true;
                    data_update.add(data);                    
                    
                    insert Listcase;
                }
                catch(Exception e){
                    System.debug('Exception occurred: ' + e.getMessage());
                }
                data.Proceed_ICF__c = true;
                update data;
            }
        }

                
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
    
}