public class CallPageTesterController{
public String currentRecordId {get;set;}
public Contact contactRec {get;set;}
public String token {get;set;}

 
    public CallPageTesterController(ApexPages.StandardController controller) {
        currentRecordId  = controller.getID();
        contactRec = [Select Policy_No__c, PolicyApp__c, Entity__c, Id from Contact where id =:currentRecordId ];
        
        CreateToken ct = new CreateToken();
        token = ct.getToken();
    }
}