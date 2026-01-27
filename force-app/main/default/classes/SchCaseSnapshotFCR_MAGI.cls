// Sch SnapShot FCR
Global class SchCaseSnapshotFCR_MAGI implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {

        date thisday = date.today();
        date lastday = date.today();
        //if (lastday.day() == 1) lastday = date.today()-1;
        //&& thisday.month() == lastday.month())  lastday = date.today();
        
        date datesnap = date.newInstance(lastday.Year(), lastday.month(), 1);
        date Lastdate = datesnap - 1;
        date Firstdate = date.newInstance(Lastdate.Year(), Lastdate.month(), 1);
        
        List <Case_Snapshot__c> delCS = [SELECT id FROM Case_Snapshot__c WHERE Entity__c = 'MAGI' and Date__c = Last_Month ]; //Date__c >=: Firstdate and Date__c <=: Lastdate
        delete delCS;
        
        List <Case_Snapshot__c> listcs = new List<Case_Snapshot__c>();

        // MAGI        
        AggregateResult[] groupedResults;
        if (test.isrunningtest()) {
        groupedResults = [SELECT CreatedById, Service_Type__c ServiceType, SUM(Age__c) age, SUM(Open__c) open, sum(Closed__c) closed, 
            sum(FCR_Count__c) fcr, sum(First_Interaction__c) f1, sum(Repeat_Call__c) repeatcall
            FROM Case
//            WHERE Entity__c = 'MAGI' and CreatedDate <=: lastday and CreatedDate >= :datesnap and No_Need_To_Reply_New__c = FALSE
            WHERE Entity__c = 'MAGI' and CreatedDate = TODAY and No_Need_To_Reply_New__c = FALSE //CreatedDate >=: Firstdate and CreatedDate <: datesnap 
                GROUP BY CreatedById, Service_Type__c ];        
        }else {
        groupedResults = [SELECT CreatedById, Service_Type__c ServiceType, SUM(Age__c) age, SUM(Open__c) open, sum(Closed__c) closed, 
            sum(FCR_Count__c) fcr, sum(First_Interaction__c) f1, sum(Repeat_Call__c) repeatcall
            FROM Case
//            WHERE Entity__c = 'MAGI' and CreatedDate <=: lastday and CreatedDate >= :datesnap and No_Need_To_Reply_New__c = FALSE
            WHERE Entity__c = 'MAGI' and CreatedDate = Last_Month and No_Need_To_Reply_New__c = FALSE //CreatedDate >=: Firstdate and CreatedDate <: datesnap 
                GROUP BY CreatedById, Service_Type__c ];
        }
                
        for (AggregateResult ar : groupedResults)  {
            id ownercase = string.valueof(ar.get('CreatedById'));
            
            Case_Snapshot__c newcs = new Case_Snapshot__c (
                Age_Days__c = integer.valueof(ar.get('age')) * 24,
                Age_Hours__c = integer.valueof(ar.get('age')),
                Closed__c = integer.valueof(ar.get('closed')),
                Date__c = Lastdate, //datesnap,
                Service_Type__c = String.valueof(ar.get('ServiceType')),
                Entity__c = 'MAGI', //string.valueof(ar.get('Entity__c')),
                FCR__c = integer.valueof(ar.get('fcr')),
                First_Interaction__c = integer.valueof(ar.get('f1')),
                Open__c = integer.valueof(ar.get('open')),
                Owner_Case__c = ownercase,
                Repeat_Call__c = integer.valueof(ar.get('repeatcall'))
            );
            listcs.add(newcs);
        }
        if (listcs.size() > 0) insert listcs;
        
    } // end execute
    
    public static string isNull(String sKata)
    {
        if(sKata == null) sKata = '';
        return sKata;
    }
} // end class