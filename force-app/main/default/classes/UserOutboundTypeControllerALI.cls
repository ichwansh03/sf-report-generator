public without sharing class UserOutboundTypeControllerALI {
    public List<User_Detail__c> UserList {get;set;}
    
    public UserOutboundTypeControllerALI(){
        List<User_Detail__c> userObj = [select id, Name, Outbound_Activity_Case_type__c from User_Detail__c ];
        //WHERE User__c != null  and User__r.isActive = TRUE
        //User__c, User__r.Name, User__r.LastName, User__r.FirstName, User__r.Entity__c,         
        UserList = new List<User_Detail__c>();
        if (userObj.size() > 0) {
            for (integer i = 0; i < userObj.size(); i++) {
                //if (userObj[i].Outbound_Activity_Case_type__c == NULL) userObj.Outbound_Activity_Case_type__c = '';
                UserList.add (userObj[i]);
            }
        }
    }
    
    public PageReference save(){
        update UserList;
        //if (UserList.Size() > 0) upsert UserList;

        return null;
    }
}