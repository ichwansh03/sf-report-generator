public class ContactCMUUpdateQueueable implements Queueable {
    
    private Database.Cursor locator;
    private Integer pos;

    public ContactCMUUpdateQueueable(){
        locator = Database.getCursor('SELECT Id, Probable_Causes__c, Policy_No__c, Policy_No_Numeric__c, Prediction__c, Complaint_Probability__c, Complaint_Risk__c, Occupation__c, mdmid_owner__c FROM CMU_Contact__c WHERE Policy_No__c != NULL ORDER BY LastModifiedDate DESC LIMIT 50000');
        pos = 0;
    }
    
    public void execute(QueueableContext ctx) {

        system.debug('total of records: '+locator.getNumRecords());
        List<CMU_Contact__c> cmuList = new List<CMU_Contact__c>(); 
        if(locator.getNumRecords() > 1000) cmuList = locator.fetch(pos, 1000);
        else cmuList = locator.fetch(pos, locator.getNumRecords());
        
        pos += cmuList.size();
        system.debug('pos: '+pos);
        Set<String> externalId = new Set<String>();
        
        for (CMU_Contact__c cmu : cmuList) {
            externalId.add(cmu.Policy_No_Numeric__c);
        }
        system.debug('external id: '+externalId);
        Map<String, Contact> contactMap = new Map<String, Contact>();
        for (Contact con : [SELECT Id, mdmid_owner__c, Probable_Causes__c, Policy_No__c, Policy_No_Numeric__c, Prediction__c, Complaint_Probability__c, Complaint_Risk__c, Occupation__c FROM Contact WHERE Policy_No_Numeric__c IN :externalId AND Entity__c = 'AMFS']) {
            contactMap.put(con.Policy_No_Numeric__c, con);
        }        
        
        List<Contact> contactEdit = new List<Contact>();
        
        for (CMU_Contact__c cmu : cmuList) {
            Contact con = contactMap.get(cmu.Policy_No_Numeric__c);
            if (cmu != null && contactMap.containsKey(cmu.Policy_No_Numeric__c)) {
                system.debug('cmu: '+cmu.Policy_No_Numeric__c);
                con.mdmid_owner__c = cmu.mdmid_owner__c;
                con.Probable_Causes__c = cmu.Probable_Causes__c;
                con.Prediction__c = cmu.Prediction__c;
                con.Complaint_Probability__c = cmu.Complaint_Probability__c;
                con.Complaint_Risk__c = cmu.Complaint_Risk__c;
                con.Occupation__c = cmu.Occupation__c;
                contactEdit.add(con);
            }
        }
        
        system.debug('update contact '+contactEdit.size());
        if (!contactEdit.isEmpty()) {
            update contactEdit;
            if (!cmuList.isEmpty()) delete cmuList;
        }
        
        //if (!contactEdit.isEmpty()) update contactEdit;
        //if (!cmuList.isEmpty()) delete cmuList;
        
        if (pos < locator.getNumRecords()) {
            system.debug('process queue again');
            system.enqueueJob(this);
        }
    }
}