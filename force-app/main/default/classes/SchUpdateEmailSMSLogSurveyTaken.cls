// Sch SnapShot FCR
Global class SchUpdateEmailSMSLogSurveyTaken implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {

        date thisday = date.today();
        date lastday = date.today();

        list<SurveyTaker__c> st = [SELECT id, Case__c, Email_SMS_Log__c FROM SurveyTaker__c WHERE Email_SMS_Log__c = NULL and Case__c != NULL LIMIT 1000];
        map<id,id> mapCaseST = new map<id,id>();
        List<String> STCase = new List<String>();
        for (integer i=0; i < st.size(); i++){
            STCase.add(st[i].Case__c);
            mapCaseST.put(st[i].Case__c, st[i].id);
        }

        List <Email_SMS_Log__c> esl = [SELECT id, Category__c, Survey_Taken__c, Case__c FROM Email_SMS_Log__c WHERE Category__c = 'ICF' and Case__c IN :STCase];

        list<SurveyTaker__c> ListSTUpdate = new list<SurveyTaker__c>();
        
        for  (integer i = 0; i < esl.size(); i++){
            esl[i].Survey_Taken__c = mapCaseST.get(esl[i].Case__c);
            SurveyTaker__c STUpdate = new SurveyTaker__c();
            STUpdate.id = mapCaseST.get(esl[i].Case__c);
            STUpdate.Email_SMS_Log__c = esl[i].id;
            ListSTUpdate.add(STUpdate);
        }
                
        if (esl.size() > 0) update esl;
        if (ListSTUpdate.size() > 0) update ListSTUpdate;
        
    } // end execute
    
    public static string isNull(String sKata)
    {
        if(sKata == null) sKata = '';
        return sKata;
    }
} // end class