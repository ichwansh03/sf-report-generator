public with sharing class CaseLogMIDSecurePayment{
    private Final Case opp;
    public List<MID_Secure_Payment__c> LogMID {get; set;}
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
   
    public CaseLogMIDSecurePayment(ApexPages.StandardController std){
        this.opp = (Case)std.getRecord();
        id CurrentUser = userInfo.getUserId();
        
        Case cs = [SELECT id, ContactId, Create_Date__c FROM Case WHERE id =: this.opp.Id];
        
        if(Test.isRunningTest())
            LogMID = [SELECT Id, Name, Case__c, Checklist__c, Log_a_Case__c, SFDC_Order_Id__c, Account_Name__c, Card_Holder_Name__c, Origin__c, Payment_Frequency__c, Payment_Type__c, Contact__c, Contact__r.Name, CreatedDate, Status__c FROM MID_Secure_Payment__c WHERE Contact__c =: cs.ContactId order by id desc];
        else
            LogMID = [SELECT Id, Name, Case__c, Checklist__c, Log_a_Case__c, SFDC_Order_Id__c, Account_Name__c, Card_Holder_Name__c, Origin__c, Payment_Frequency__c, Payment_Type__c, Contact__c, Contact__r.Name, CreatedDate, Status__c FROM MID_Secure_Payment__c WHERE Contact__c =: cs.ContactId and Create_Date__c =: cs.Create_Date__c order by Case__c desc, id desc];
        VisibleButton = FALSE;
        if (LogMID.Size() > 0) {
            system.debug('#LogMID.Size() : '+LogMID.Size());
            //if (LogMID[0].Contact__c != NULL) OldContact = LogMID[0].Contact__r.Name;
            ContactID = this.opp.id;
            if (LogMID[0].Case__c == NULL) VisibleButton = TRUE;
            for (integer i = 0; i < LogMID.size(); i++){
                if (LogMID[i].Case__c != NULL) LogMID[i].Log_a_Case__c = TRUE;
            }
        }
    }
    
    Public PageReference Save(){
        Savepoint spoint = Database.setSavepoint();
        try{
            if (LogMID.size() > 0) {
                for (integer i = 0; i < LogMID.size(); i++){
                    if (LogMID[i].Checklist__c) LogMID[i].Case__c = ContactID;
                    if (LogMID[i].Checklist__c) LogMID[i].Log_a_Case__c = TRUE;
                }
                Update LogMID;
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