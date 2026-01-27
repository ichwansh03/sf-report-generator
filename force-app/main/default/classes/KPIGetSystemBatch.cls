global class KPIGetSystemBatch implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts{
  global String query;
    global String url;
    global String shorturl;
    global KPIGetSystemBatch(String q) {
        this.query = q;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug(LoggingLevel.DEBUG, '***QUERY BATCH: ' + query);
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Agent_Performance__c> scope){
        List<Agent_Performance__c> ScopeUpdate = new List<Agent_Performance__c>();
        for(Agent_Performance__c s : scope){
            if (s.Agree_to_Redebet_Data_Auto__c == 'Yes') {                s.Agree_to_Redebet_Data_Auto__c = 'No';
            }
            
            if (s.Agree_to_Reinstate_Data_Auto__c == 'Yes') {                s.Agree_to_Reinstate_Data_Auto__c = 'No';
            }
            
            if (s.AHT_Data_Auto__c == 'Yes') {                s.AHT_Data_Auto__c = 'No';
            }
            
            if (s.Attempt_Call_Data_Auto__c == 'Yes') {
                //s.Attempt_Call_Data_Auto__c = 'No';
                // check di Log_CTI_Valdo__c
                integer Attemp = [SELECT count() FROM Log_CTI_Valdo__c WHERE Agent__c =:s.Agent__c and Periode__c =:s.Periode__c and Status__c ='Outbound'];
                s.Attempt_Call_Data_System__c = Attemp;
                
            }
            
            if (s.Attendance_Data_Auto__c == 'Yes') {                s.Attendance_Data_Auto__c = 'No';

            }
            
            if (s.Aux_Data_Auto__c == 'Yes') {                s.Aux_Data_Auto__c = 'No';
            }
            
            if (s.Call_Monitoring_Data_Auto__c == 'Yes') {                s.Call_Monitoring_Data_Auto__c = 'No';
            }
            
            if (s.Cases_Data_Auto__c == 'Yes') {                s.Cases_Data_Auto__c = 'No';
            }
            
            if (s.Contact_Rate_Data_Auto__c == 'Yes') {                s.Contact_Rate_Data_Auto__c = 'No';
            }
            
            if (s.Email_WA_Data_Auto__c == 'Yes') {                s.Email_WA_Data_Auto__c = 'No';
            }
                        
            if (s.Error_Rate_Data_Auto__c == 'Yes') {                s.Error_Rate_Data_Auto__c = 'No';
            }
            
            if (s.Inforce_Data_Auto__c == 'Yes') {                s.Inforce_Data_Auto__c = 'No';
            }
            
            if (s.Late_Time_Data_Auto__c == 'Yes') {                s.Late_Time_Data_Auto__c = 'No';
            }
            
            if (s.Quiz_Data_Auto__c == 'Yes') {                s.Quiz_Data_Auto__c = 'No';
            }
            
            if (s.Referral_Data_Auto__c == 'Yes') {                s.Referral_Data_Auto__c = 'No';
            }
            
            if (s.Survey_Push_Rate_Data_Auto__c == 'Yes'){                s.Survey_Push_Rate_Data_Auto__c = 'No';
            }
            ScopeUpdate.add(s);
        }  
        update ScopeUpdate;
    }

    global void finish(Database.BatchableContext BC){

    }
}