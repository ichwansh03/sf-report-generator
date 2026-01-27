public class ProductivityDetail_Ctrl {
    Id rtWelcomCallId = Schema.SObjectType.Call_Line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
    Public Date startDate {get;set;}
    Public Date endDate {get; set;}
    Public List<Call_Line__c> listCallLine {get;set;}
    public string HeaderName {get;set;}
    
    /**
     * get Call line welcome call by
     * start date, end date, owner id
     */
    public Map<Integer, Call_Line__c> getDetails(){
        String activity = apexpages.currentPage().getParameters().get('act');
        String startDt = apexpages.currentPage().getParameters().get('st');
        String endDt = apexpages.currentPage().getParameters().get('en');
        String owner = apexpages.currentPage().getParameters().get('own');
        startDate = Date.parse(startDt);
        endDate = Date.parse(endDt);
        HeaderName = activity;
        List<Call_Line__c> callLines =new List<Call_Line__c>();
        if(activity.toUpperCase() == 'ALL CALLS' || activity.toUpperCase() == 'ATTEMPT'){
        callLines =[select  name, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c,  
                                       WelcomeCall_Detail_Status__c, WelcomeCall_Reason_Detail_Status__c, Notes__c, 
                    				   Policy_No__c,Contact__r.lastName, WelcomeCall_Criteria__c,
                                       WelcomeCall_Schedule_Date__c, Phone__c, Contacted_Number__c, Home_Phone__c,  Other_Phone__c, 
                                       Expired_Date__c, Owner.Name, WelcomeCall_Attempt__c, Formula_Product__c
                                       from Call_Line__c
                                       where recordTypeId =: rtWelcomCallId and ownerid = :owner
                                       and (WelcomeCall_Schedule_Date__c >=: startDate and WelcomeCall_Schedule_Date__c <=: endDate)];
        }  else if(activity.toUpperCase() == 'CLOSED'){
        callLines =[select  name, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c,  
                                       WelcomeCall_Detail_Status__c, WelcomeCall_Reason_Detail_Status__c, Notes__c, 
                                       Policy_No__c, Contact__r.lastName, WelcomeCall_Criteria__c,
                                       WelcomeCall_Schedule_Date__c, Phone__c, Contacted_Number__c, Home_Phone__c,  Other_Phone__c, 
                                       Expired_Date__c, Owner.Name, WelcomeCall_Attempt__c, Formula_Product__c 
                                       from Call_Line__c
                                       where recordTypeId =: rtWelcomCallId
                                       and WelcomeCall_Call_Line_Status__c =: activity and ownerid = :owner
                                       and (WelcomeCall_Schedule_Date__c >=: startDate and WelcomeCall_Schedule_Date__c <=: endDate)];
        } else{
        callLines =[select  name, WelcomeCall_Call_Line_Status__c, Activity_Result__c, Verification__c,  
                                       WelcomeCall_Detail_Status__c, WelcomeCall_Reason_Detail_Status__c, Notes__c, 
                                       Policy_No__c, Contact__r.lastName, WelcomeCall_Criteria__c,
                                       WelcomeCall_Schedule_Date__c, Phone__c, Contacted_Number__c, Home_Phone__c,  Other_Phone__c, 
                                       Expired_Date__c, Owner.Name, WelcomeCall_Attempt__c, Formula_Product__c 
                                       from Call_Line__c
                                       where recordTypeId =: rtWelcomCallId
                                       and Activity_Result__c =: activity and ownerid = :owner
                                       and (WelcomeCall_Schedule_Date__c >=: startDate and WelcomeCall_Schedule_Date__c <=: endDate)];
        }
        Map<Integer, Call_Line__c> mapCL = new Map<Integer, Call_Line__c>();
        Integer i=1;
        for(Call_Line__c cl : callLines){
            mapCL.put(i, cl);
            i++;
        }
        return mapCL;
    }

}