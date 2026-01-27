trigger validation_leave on WelcomeCall_Leave__c (before insert) {
    date startdate {get;set;}
    date Endate {get;set;}
    String agentId{get;set;}
    if(Trigger.isBefore){
        
        for(WelcomeCall_Leave__c  i:trigger.new) {
            startdate = i.WelcomeCall_Start_Date__c;
            Endate = i.WelcomeCall_End_Date__c;
            agentId = i.WelcomeCall_Agent__c;
        }
        List<WelcomeCall_Leave__c> leave = [select id, WelcomeCall_Start_Date__c, WelcomeCall_End_Date__c, WelcomeCall_Agent__c 
                                            from WelcomeCall_Leave__c where WelcomeCall_Agent__c = :agentId and 
                                            ((WelcomeCall_Start_Date__c <= :startdate and WelcomeCall_End_Date__c >= :Endate) or
                                             (WelcomeCall_Start_Date__c <= :startdate and WelcomeCall_End_Date__c >= :startdate) or
                                             (WelcomeCall_Start_Date__c <= :Endate and WelcomeCall_End_Date__c >= :startdate)
                                             
                                            )
                                            
                                           ];
        if(!leave.isEmpty()){
            Trigger.New[0].WelcomeCall_Start_Date__c.addError('Can not created leave because Agent already has leave at same range date');
        }
    }
}