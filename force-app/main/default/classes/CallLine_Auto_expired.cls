global class CallLine_Auto_expired implements Schedulable{
    global void execute(SchedulableContext SC) {
        //Call_Line__c callLine = new Call_Line__c();
        Id rtCallLineWC = Schema.SObjectType.Call_line__c.getRecordTypeInfosByName().get('Welcome Call').getRecordTypeId();
        List<Call_line__c> cls =[select id, name, Call_Remarks__c, Is_Expired__c, WelcomeCall_Call_Line_Status__c 
                                      from Call_Line__c 
                                      where Is_Expired__c = true 
                                 	  and recordTypeid =: rtCallLineWC
                                      and WelcomeCall_Call_Line_Status__c != 'closed'];
        for(Call_Line__c call_line : cls){
            call_line.Call_Remarks__c = System.Label.welcome_call_expired_remarks;
            Call_Line.WelcomeCall_Call_Line_Status__c = 'Closed';
        }
        update cls;
        System.debug('===Auto Expired success===');
    }
    
}