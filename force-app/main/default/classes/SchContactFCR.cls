// Sch SnapShot FCR ke Contact
Global class SchContactFCR implements Schedulable {

  public static String CRON_EXP = '0 0 0 3 9 ? 2022';

    Global void execute(SchedulableContext ctx) {
        Date TodayDate = Date.today();
        Date Tanggal = TodayDate;

        Date StartDate = Tanggal;
        Date EndDate = Tanggal;

        StartDate = date.newInstance(TodayDate.Year(), TodayDate.Month(), 1);
        EndDate = StartDate.addMonths(1);
                    
            
        //Tanggal = date.newInstance(TodayDate.Year(), 1, 1);
        list<id> listct = new list<id>();
        string tempid = '';
        
        list<case> listcase = new list<case>();
        /*
        if (StartDate.month() == 1) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Jan__c <: StartDate and Contact.Last_Case_Jan__c >=: EndDate) OR Contact.Last_Case_Jan__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 2) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Feb__c <: StartDate and Contact.Last_Case_Feb__c >=: EndDate) OR Contact.Last_Case_Feb__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 3) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Mar__c <: StartDate and Contact.Last_Case_Mar__c >=: EndDate) OR Contact.Last_Case_Mar__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 4) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Apr__c <: StartDate and Contact.Last_Case_Apr__c >=: EndDate) OR Contact.Last_Case_Apr__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 5) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Mei__c <: StartDate and Contact.Last_Case_Mei__c >=: EndDate) OR Contact.Last_Case_Mei__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 6) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Jun__c <: StartDate and Contact.Last_Case_Jun__c >=: EndDate) OR Contact.Last_Case_Jun__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 7) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Jul__c <: StartDate and Contact.Last_Case_Jul__c >=: EndDate) OR Contact.Last_Case_Jul__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 8) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Agt__c <: StartDate and Contact.Last_Case_Agt__c >=: EndDate) OR Contact.Last_Case_Agt__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 9) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Sep__c <: StartDate and Contact.Last_Case_Sep__c >=: EndDate) OR Contact.Last_Case_Sep__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 10) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Okt__c <: StartDate and Contact.Last_Case_Okt__c >=: EndDate) OR Contact.Last_Case_Okt__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 11) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Nov__c <: StartDate and Contact.Last_Case_Nov__c >=: EndDate) OR Contact.Last_Case_Nov__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        if (StartDate.month() == 12) listcase = [SELECT id, ContactId FROM Case
                        WHERE Create_Date__c >=: StartDate and Create_Date__c <: EndDate and ContactId != NULL and ((Contact.Last_Case_Des__c <: StartDate and Contact.Last_Case_Des__c >=: EndDate) OR Contact.Last_Case_Des__c = NULL)
                        Order BY ContactId
                        limit 10000
                       ];
        */
        listcase = [SELECT id, ContactId FROM Case WHERE Create_Date__c =: TodayDate and ContactId != NULL Order BY ContactId];
        for (case cs : listcase) {
            if (tempid != string.valueof(cs.Contactid) ) {
                tempid = string.valueof(cs.Contactid);
                //listct.add(cs.Contactid);
                listct.add(id.valueof(tempid));
            }
            //listcase.add(cs.id);
        }
        //SchCalc.FCRCaseDate(Tanggal, );          
        System.debug('listct.size() : '+listct.size());
        if (listct.size() > 0) {
            //update UpdateBA;
            SchContactFCR_Batch ba = new SchContactFCR_Batch(listct, Tanggal);
            //Database.executeBatch(ba, 100);
            Database.executeBatch(ba, 10);
        }
                
    } // end execute
    
} // end class