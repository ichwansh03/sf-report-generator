public class TransferContactControllerALI {
    public Assign_Log__c newLog {get;set;}
    public String retURL {get; set;}
            
    public TransferContactControllerALI(){
        retURL = Apexpages.currentPage().getParameters().get('retURL');
        
        user us = [SELECT id, Entity__c, SIP__c FROM User WHERE id =:UserInfo.getUserId() ]; 
        List<Group> gp;
        string userSIP = 'SIP '+us.SIP__c;
        gp = [select id from Group WHERE Type = 'Queue' and Name = :userSIP limit 1];
        if (gp.size() == 0)
            gp = [select id from Group WHERE Type = 'Queue' and Name like '%SIP%' limit 1];
        newLog = new Assign_Log__c();
        newLog.Contact__c = ApexPages.currentPage().getParameters().get('id');
        newLog.From_User__c = UserInfo.getUserId();
        newLog.Entity__c = us.Entity__c;

        if (gp.size() > 0)
            newLog.OwnerId = gp[0].id;

    }
    
    public PageReference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            insert newLog;
            return new PageReference(retURL);
        }catch(System.DmlException e){ 
            Database.rollback(spoint);
            return null; 
        }
    }
}