// Log CTI Valdo direct to Contact
public class ALIConsoleRedirectController {
  private ApexPages.StandardController controller;
    public Contact ContactObj {get;set;}
    public String ContactId {get;set;}
    public String AMId {get;set;}
    
    public ALIConsoleRedirectController(ApexPages.StandardController controller) {
        this.controller = controller;
        Log_CTI_Valdo__c c1 = (Log_CTI_Valdo__c) controller.getRecord();
        AMId = c1.Id;
        ContactObj = getContact(AMId);
        //ContactId = c1.Id; 
        //ContactObj = getContact(ContactId);
    }
    
    public Contact getContact(String pContactId) {
        DescribeSObjectResult describeResultContact = Contact.getSObjectType().getDescribe();
        List<String> ContactFieldList = new List<String>(describeResultContact.fields.getMap().keySet());
        String ContactFields = String.join(ContactFieldList, ',');
        
        // check Contact ID
        Log_CTI_Valdo__c am = [SELECT id, From__c, Contact__c FROM Log_CTI_Valdo__c WHERE id =: pContactId ];
        String pContactId2 = am.Contact__c;
        String MobileContact = am.From__c;
        ContactId = am.Contact__c;
        string Entity = 'ALI';
        //String ContactQuery = ' SELECT ' + ContactFields + ' FROM Contact WHERE (MobilePhone =: MobileContact or Phone =: MobileContact) AND Entity__c =: Entity ORDER BY CreatedDate ASC LIMIT 1';
        String ContactQuery = ' SELECT ' + ContactFields + ' FROM Contact WHERE (MobilePhone =: MobileContact or Phone =: MobileContact) ORDER BY CreatedDate ASC LIMIT 1';
        //am.addError(''+ContactQuery);
        List<Contact> ContactResultList = Database.query(ContactQuery);
        Contact ContactResult = new Contact();
        if (ContactResultList.size() > 1) ContactResult = ContactResultList.get(0);
        else if (ContactResultList.size() == 1) ContactResult = ContactResultList.get(0);
                
        return ContactResult;
    }
}