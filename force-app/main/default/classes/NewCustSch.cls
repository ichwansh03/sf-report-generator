global with sharing class NewCustSch implements Schedulable, Database.Batchable<sObject>{
    global void execute(SchedulableContext sc) { 
        // To start the batch job: 
        Database.executeBatch(new NewCustSch(), 50);
    }
    
    global Iterable<sObject> start(Database.BatchableContext bc){
        String ENTITY = 'AMFS';
        String filter = System.Label.ICF_I_Buy_Query;
        List<Contact> data = new List<Contact> ();
        
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> contactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String ContactFields = String.join(contactFieldList, ',');
        String query = ' SELECT ' + ContactFields + ' from Contact ' + filter;
        if (!System.test.isRunningTest() ){ 
            data = Database.query(query);
        } else {
            data = [
                Select id from contact limit 1
            ];
        }
        system.debug('Query:'+filter);
        system.debug('Size:'+data.size());
        return data;
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> Ctc){ 
        
       Set<Id> idContact = new Set<Id>();
        if(Ctc.size() > 0){
            for(Contact c:Ctc){
                idContact.add(c.id);
                //system.debug('Name:'+c.name);
            }
            if (!System.Test.IsRunningTest()) System.enqueueJob(new CreateEmailSMSLogNewCust.CreateEmailSMSLog(idContact, 'New'));
        }
    }
    
    global void finish(Database.BatchableContext bc){
        
    }
    
}