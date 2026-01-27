public with sharing class ContactLogCTIValdo{
    private Final Contact opp;
    public List<Log_CTI_Valdo__c> LogCTI {get; set;}
    public String OldContact {get; set;}
    public String PolicyNo {get; set;}
    public ID ContactID {get; set;}
    public Boolean VisibleButton {get; set;}
    public String idprospect{
        get {
            return this.opp.id;
        }
        private set;
    }
   
    public ContactLogCTIValdo(ApexPages.StandardController std){
        this.opp = (Contact)std.getRecord();
        id CurrentUser = userInfo.getUserId();
        LogCTI = [SELECT Id, Name, Contact__c, Contact__r.Name, Current_Phone__c, CreatedDate, Status__c FROM Log_CTI_Valdo__c WHERE OwnerId =: CurrentUser order by id desc LIMIT 1];
        VisibleButton = FALSE;
        if (LogCTI.Size() > 0) {
            //if (LogCTI[0].Contact__c != NULL) OldContact = LogCTI[0].Contact__r.Name;
            ContactID = this.opp.id;
            if (LogCTI[0].Contact__c == NULL) VisibleButton = TRUE;
        }
    }
    
    Public PageReference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            if (LogCTI.size() > 0) {
                LogCTI[0].Contact__c = ContactID;
                Update LogCTI;
                OldContact = 'Updated..';
                VisibleButton = FALSE;
            }
            return null;
        }catch(System.DmlException e){
            Database.rollback(spoint); 
            return null;
        }
    }
}